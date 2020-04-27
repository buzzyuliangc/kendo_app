//
//  WorkoutFormEntry.swift
//  kendo
//
//  Created by Ian Loftis on 3/6/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import Foundation

// this class is used to keep track of the workout forms created by the user

class WorkoutFormEntry: NSObject, NSCoding {
    
    //encode function for NSCoder, used when encoding the WorkoutObjects for UserDefaults
    func encode(with coder: NSCoder) {
        coder.encode(form, forKey:"form")
        coder.encode(frequency, forKey: "frequency")
        coder.encode(restTime, forKey: "restTime")
        coder.encode(parentWorkout, forKey: "parentWorkout")
        coder.encode(numSwings, forKey: "numSwings")
        coder.encode(id, forKey: "id")
    }
    
    //init function for NSCoder, used when encoding hte WorkoutObjects for UserDefaults
    required convenience init(coder: NSCoder) {
        let form = coder.decodeObject(forKey: "form") as! String
        let frequency = coder.decodeDouble(forKey: "frequency")
        let restTime = coder.decodeInteger(forKey: "restTime")
        let parentWorkout = coder.decodeObject(forKey: "parentWorkout") as! WorkoutObject
        let numSwings = coder.decodeInteger(forKey: "numSwings")
        let id = coder.decodeInteger(forKey: "id")
        
        self.init(form: form, frequency: frequency, restTime: restTime, numSwings: numSwings, parentWorkout: parentWorkout, id: id)
    }
    
    //form of swing used
    var form: String 

    //delay between swings in seconds
    var frequency: Double 

    //The speed selection as an index of the speed options list from Constants.swift
    var speedSelection: Int

    //rest time after form
    var restTime: Int 

    //the parent workout
    var parentWorkout: WorkoutObject

    //the number of swings for the form
    var numSwings: Int

    //the id of the form object
    var id: Int
    
//    init() {
//        self.form = Constants.defaultForm
//        self.frequency = Constants.defaultFrequency
//        self.restTime = Constants.defaultRestTime
//        self.numSwings = Constants.defaultSwingCount
//        self.speedSelection = Constants.defaultSpeedSelections
//    }
    
    //inits the WorkoutFormEntry from the given values
    init(form: String, frequency: Double, restTime: Int, numSwings: Int, parentWorkout: WorkoutObject, id:Int) {
        self.form = form;
        self.frequency = frequency
        self.restTime = restTime
        self.numSwings = numSwings
        self.parentWorkout = parentWorkout
        self.id = id
        self.speedSelection = Constants.defaultSpeedSelection
    }
    
    //inits a WorkoutFormEntry as a copy of a given WorkoutFormEntry
    init(fromWorkoutFormEntry: WorkoutFormEntry) {
        self.form = fromWorkoutFormEntry.getForm()
        self.frequency = fromWorkoutFormEntry.getFrequency()
        self.restTime = fromWorkoutFormEntry.getRestTime()
        self.numSwings = fromWorkoutFormEntry.getNumSwings()
        self.parentWorkout = fromWorkoutFormEntry.getParentWorkout()
        self.speedSelection = fromWorkoutFormEntry.getSpeedSelection()
        self.id = fromWorkoutFormEntry.getId()
    }
    
    //getters and setters
    func setSpeedSelection(speedSelection: Int) {
        self.speedSelection = speedSelection
    }
    
    func getSpeedSelection() -> Int{
        return self.speedSelection
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
    
    func setId(id: Int) {
        self.id = id
    }
    
    func getId() -> Int {
        return self.id
    }
    
    
}
