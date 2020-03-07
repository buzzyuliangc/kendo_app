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
    }
    
    func incSwing() {
        if(self.swingNum < self.swingMax) {
            self.swingNum += 1
        }
//        else if(self.swingNum > self.swingMax) {
        else {
            if(self.formIndex < workout.getForms().count){
                enterRest()
            }
            else {
                endWorkout()
            }
        }
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
    }
    
    func endRest() {
        self.runningTime = 0.0
        self.resting = false
        incForm()
    }
    
    func incForm() {
        self.formIndex += 1
        self.runningTime = 0.0
        self.swingNum = 0
        if(self.formIndex < workout.getForms().count) {
            loadForm(newForm: workout.getForm(formIndex: self.formIndex))
        }
    }
    
    func incTime(inc: Double) {
        if(self.active) {
            elapsedTime += inc
            runningTime += inc
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
    }
    
    func toggle() {
        if(self.active) {
            self.active = false
        } else {
            self.active = true;
        }
        
    }
    
}
