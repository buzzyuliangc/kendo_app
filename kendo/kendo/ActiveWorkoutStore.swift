//
//  ActiveWorkoutStore.swift
//  kendo
//
//  Created by Ian Loftis on 3/7/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

//The purpose of this class is to act as a store for the active workout being ran
//it should hold the workout plan and maintain the current state of the workout
//this should be used by the workout view. The view should subscribe to the publisher.

//TODO: ensure that the workout object being passed to this is not empty
//      This should be enforced by denying the user the ability to save an empty workout in the builder

import Foundation

class ActiveWorkoutStore: ObservableObject {
    //var didChange = Some kind of publisher
    var workout: WorkoutObject
    var timer = Timer()
    var counterAudioPlayer = CounterAudioPlayer()
    @Published var formIndex = 0
    @Published var activeForm: WorkoutFormEntry
    @Published var active: Bool = false
    @Published var formName = ""
    @Published var swingNum = 0
    @Published var swingMax = 0
    @Published var resting: Bool = false
    @Published var restTime = 0
    @Published var swingWait = 0.0
    @Published var elapsedTime = 0.0
    @Published var runningTime = 0.0
    @Published var numForms = 0
    @Published var subSwingIndex = 0
    @Published var subSwingCount = 1
    @Published var subSwingWait = 0.0
    @Published var runningSubSwingTime = 0.0
    @Published var subSwing = 1
    @Published var done: Bool = false
    
    init(workout: WorkoutObject) {
        self.workout = workout
        self.formIndex = 0
        self.active = true
        self.numForms = workout.getForms().count
        self.activeForm = workout.getForm(formIndex: 0)
        self.formName = self.activeForm.getForm()
        self.swingNum = 0
        self.swingMax = self.activeForm.getNumSwings()
        self.resting = false
        self.restTime = self.activeForm.getRestTime()
        self.swingWait = self.activeForm.getFrequency()
        
        let numSubs = Constants.formSubSwings[formName]?.count
        if(numSubs != nil) {
            self.subSwingWait = self.swingWait/Double(numSubs!)
            self.subSwingCount = numSubs!
        } else {
            self.subSwingWait = self.activeForm.getFrequency()
        }
        resetSubSwing()
        loadForm(newForm: workout.getForm(formIndex: 0))
    }
    
    func loadForm(newForm: WorkoutFormEntry) {
        self.activeForm = newForm
        self.formName = newForm.getForm()
        self.swingNum = 0
        self.swingMax = newForm.getNumSwings()
        self.resting = false
        self.restTime = newForm.getRestTime()
        self.swingWait = newForm.getFrequency()
        
        let numSubs = Constants.formSubSwings[newForm.getForm()]?.count
        if(numSubs != nil) {
            self.subSwingWait = self.swingWait/Double(numSubs!)
            self.subSwingCount = numSubs!
        } else {
            self.subSwingWait = self.activeForm.getFrequency()
        }
        
    }
    
    func incSwing() {
        resetSubSwing()
        if(self.swingNum < self.swingMax) {
            self.swingNum += 1
            
            counterAudioPlayer.playCount(num: self.swingNum)
            
        }
        else {
            if(self.formIndex < workout.getForms().count){
                enterRest()
            }
            else {
                endWorkout()
            }
        }
    }
    
    func resetSubSwing() {
        self.subSwingIndex = 0
        let subSwingArray = Constants.formSubSwings[self.formName] ?? [1]
        self.subSwing = subSwingArray[self.subSwingIndex]
    }
    
    func incSubSwing() {
        self.subSwingIndex += 1
        
        let subSwingArray = Constants.formSubSwings[self.formName] ?? [1]
        print(self.formName)
        print(subSwingArray)
        print(subSwingIndex)
        if(self.subSwingIndex < subSwingArray.count) {
            self.subSwing = subSwingArray[self.subSwingIndex]
        }
        self.runningSubSwingTime = 0.0
    }
    
    func start(inc: Double) {
        if(!self.timer.isValid) {
            self.timer = Timer.scheduledTimer(withTimeInterval: inc, repeats: true) { timer in
                self.incTime(inc: inc)
            }
        }
    }
    
    func start() {
        start(inc: 0.1)
    }
    
    func enterRest() {
        self.runningTime = 0.0
        self.resting = true
        self.subSwing = -1
    }
    
    func endRest() {
        self.runningTime = 0.0
        self.resting = false
        incForm()
    }
    
    func incForm() {
        if(self.formIndex < workout.getForms().count) {
            self.formIndex += 1
            self.runningTime = 0.0
            self.swingNum = 0
            loadForm(newForm: workout.getForm(formIndex: self.formIndex))
        } else {
            endWorkout()
        }
    }
    
    func incTime(inc: Double) {
        if(self.active) {
            elapsedTime += inc
            runningTime += inc
            runningSubSwingTime += inc
            
            if(runningTime >= self.subSwingWait && self.subSwingIndex < subSwingCount - 1 && self.resting == false) {
                incSubSwing()
            }
            if(runningTime >= self.swingWait && self.resting == false) {
                incSwing()
                runningTime = 0.0
            } else if (self.resting == true && Int(runningTime) > self.restTime){
                endRest()
            }
        }
    }
    
    func incTime() {
        incTime(inc: 0.1)
    }
    
    func endWorkout() {
        timer.invalidate()
        self.active = false
        self.done = true
    }
    
    func toggle() {
        if(self.active) {
            self.active = false
        } else {
            self.active = true;
        }
        
    }
    
}
