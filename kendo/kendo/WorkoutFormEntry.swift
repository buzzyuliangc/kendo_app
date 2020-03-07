//
//  WorkoutFormEntry.swift
//  kendo
//
//  Created by Ian Loftis on 3/6/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import Foundation

class WorkoutFormEntry {
    var form: String //form of swing used
    var frequency: Double //delay between swings in seconds
    var restTime: Int //rest time after form
    var parentWorkout: WorkoutObject
    var numSwings: Int
    //TODO: decide how to store the differences between forms,
    //      if it's something to be looked up from the string or if it's something to be
    //      contained in it's own data structure
    
//    init() {
//        //possibly move these to globally defined default variables
//        self.form = "Default Form"
//        self.frequency = 200/60
//        self.restTime = 15
//        self.parentWorkout = nil;
//    }
    
    init(form: String, frequency: Double, restTime: Int, numSwings: Int, parentWorkout: WorkoutObject) {
        self.form = form;
        self.frequency = frequency
        self.restTime = restTime
        self.numSwings = numSwings
        self.parentWorkout = parentWorkout
    }
    
    func setNumSwings(numSwings: Int) {
        self.numSwings = numSwings
    }
    
    func getNumSwings() -> Int {
        return self.numSwings
    }
    
    func setForm(form: String) {
        self.form = form
    }
    
    func getForm() -> String {
        return self.form
    }
    
    func setFrequency(frequency: Double) {
        self.frequency = frequency
    }
    
    func getFrequency() -> Double{
        return self.frequency
    }
    
    func setRestTime(restTime: Int) {
        self.restTime = restTime
    }
    
    func getRestTime() -> Int {
        return self.restTime
    }
    
    func setParentWorkout(parentWorkout: WorkoutObject) {
        self.parentWorkout = parentWorkout
    }
    
    func getParentWorkout() -> WorkoutObject {
        return self.parentWorkout
    }
    
    
}
