//
//  WorkoutFormEntry.swift
//  kendo
//
//  Created by Ian Loftis on 3/6/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import Foundation

class WorkoutFormEntry: NSObject, NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(form, forKey:"form")
        coder.encode(frequency, forKey: "frequency")
        coder.encode(restTime, forKey: "restTime")
        coder.encode(parentWorkout, forKey: "parentWorkout")
        coder.encode(numSwings, forKey: "numSwings")
        coder.encode(id, forKey: "id")
    }
    
    required convenience init(coder: NSCoder) {
        let form = coder.decodeObject(forKey: "form") as! String
        let frequency = coder.decodeDouble(forKey: "frequency")
        let restTime = coder.decodeInteger(forKey: "restTime")
        let parentWorkout = coder.decodeObject(forKey: "parentWorkout") as! WorkoutObject
        let numSwings = coder.decodeInteger(forKey: "numSwings")
        let id = coder.decodeInteger(forKey: "id")
        
        self.init(form: form, frequency: frequency, restTime: restTime, numSwings: numSwings, parentWorkout: parentWorkout, id: id)
    }
    
    var form: String //form of swing used
    var frequency: Double //delay between swings in seconds
    var speedSelection: Int
    var restTime: Int //rest time after form
    var parentWorkout: WorkoutObject
    var numSwings: Int
    var id: Int
    //TODO: decide how to store the differences between forms,
    //      if it's something to be looked up from the string or if it's something to be
    //      contained in it's own data structure
    
//    init() {
//        self.form = Constants.defaultForm
//        self.frequency = Constants.defaultFrequency
//        self.restTime = Constants.defaultRestTime
//        self.numSwings = Constants.defaultSwingCount
//        self.speedSelection = Constants.defaultSpeedSelections
//    }
    
    init(form: String, frequency: Double, restTime: Int, numSwings: Int, parentWorkout: WorkoutObject, id:Int) {
        self.form = form;
        self.frequency = frequency
        self.restTime = restTime
        self.numSwings = numSwings
        self.parentWorkout = parentWorkout
        self.id = id
        self.speedSelection = Constants.defaultSpeedSelection
    }
    
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
