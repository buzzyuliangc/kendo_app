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
    //The workout object of the current workout
    var workout: WorkoutObject

    //The timer for the active workout
    var timer = Timer()

    //The audio player class for playing audio counts
    var counterAudioPlayer = CounterAudioPlayer()

    //The index of the current form in the workout's form list
    @Published var formIndex = 0

    //The active form being counted out
    @Published var activeForm: WorkoutFormEntry

    //Bool for whether the workout is active
    @Published var active: Bool = false

    //String for the name of the current active form
    @Published var formName = ""

    //The number of swings performed
    @Published var swingNum = 0

    //The max number of swings for the current form
    @Published var swingMax = 0

    //The current resting state for the workout
    @Published var resting: Bool = false

    //The time spent in the current rest state
    @Published var restTime = 0

    //The wait time between full swings
    @Published var swingWait = 0.0

    //The total amount of elapsed time
    @Published var elapsedTime = 0.0

    //The amount of running time for the current state of the workout
    @Published var runningTime = 0.0

    //The number of forms for the workout
    @Published var numForms = 0

    //The index of the current sub-swing in the current full-swing
    @Published var subSwingIndex = 0

    //The count of sub-swings
    @Published var subSwingCount = 1

    //The amount of time to wait between sub-swings for the current form
    @Published var subSwingWait = 0.0

    //Similar to running time but for the sub-swing
    @Published var runningSubSwingTime = 0.0

    //The actual id of the current sub-swing
    @Published var subSwing = 1

    //Whether the workout is done
    @Published var done: Bool = false
    

    //inits the variables, loading values from the workout object when needed
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
    
    //Updates necessary values from the new form object to be loaded
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
    
    //increments the swing
    func incSwing() {

        //resets the values associated with the subswings
        resetSubSwing()

        //If the swing number is below the max of the swings, increment and play the count audio
        if(self.swingNum < self.swingMax) {
            self.swingNum += 1
            
            counterAudioPlayer.playCount(num: self.swingNum)
            
        }
        //else it's the end of the form and a rest period should be entered
        //or the workout should end
        else {
            if(self.formIndex < workout.getForms().count){
                enterRest()
            }
            else {
                endWorkout()
            }
        }
    }
    
    //resets the values associated with the subswing
    func resetSubSwing() {
        self.subSwingIndex = 0
        let subSwingArray = Constants.formSubSwings[self.formName] ?? [1]
        self.subSwing = subSwingArray[self.subSwingIndex]
    }
    
    //increments the subswing
    func incSubSwing() {
        self.subSwingIndex += 1
        
        let subSwingArray = Constants.formSubSwings[self.formName] ?? [1]
        //print(self.formName)
        //print(subSwingArray)
        //print(subSwingIndex)
        if(self.subSwingIndex < subSwingArray.count) {
            self.subSwing = subSwingArray[self.subSwingIndex]
        }
        self.runningSubSwingTime = 0.0
    }
    
    //starts the timer (and therefore the workout) to call increment at the given step size
    func start(inc: Double) {
        if(!self.timer.isValid) {
            self.timer = Timer.scheduledTimer(withTimeInterval: inc, repeats: true) { timer in
                self.incTime(inc: inc)
            }
        }
    }
    
    //starts the workout with a default 0.1s step size
    func start() {
        start(inc: 0.1)
    }
    
    //enters the rest state
    func enterRest() {
        self.runningTime = 0.0
        self.resting = true
        self.subSwing = -1
    }
    
    //ends the rest state and calls increment on the form
    func endRest() {
        self.runningTime = 0.0
        self.resting = false
        incForm()
    }
    
    //increments the form, loading the new one, ends workout if there's none to load
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
    
    //increments the time by a given step size, triggers events at various wait values
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
    
    //increments time by a fixed 0.1s step size
    func incTime() {
        incTime(inc: 0.1)
    }
    
    //ends the workout, stopping the timer and setting active and done values
    func endWorkout() {
        timer.invalidate()
        self.active = false
        self.done = true
    }
    
    //toggles the workout to paused or unpaused
    func toggle() {
        if(self.active) {
            self.active = false
        } else {
            self.active = true;
        }
        
    }
    
}
