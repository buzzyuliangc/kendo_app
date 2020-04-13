//
//  File.swift
//  kendo
//
//  Created by Ian Loftis on 4/12/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import Foundation

class Helper {
    static func saveWorkoutList(workoutList: Array<WorkoutObject>) {
        var newWorkoutList = Array<WorkoutObject>()
        for workoutObj in workoutList {
            var newWorkout = WorkoutObject.init()
            newWorkout.setName(name: workoutObj.getName())
            newWorkout.setId(id: workoutObj.getId())
            for formEntry in workoutObj.getForms() {
                newWorkout.addForm(form: WorkoutFormEntry.init(form: formEntry.getForm(), frequency: formEntry.getFrequency(), restTime: formEntry.getRestTime(), numSwings: formEntry.getNumSwings(), parentWorkout: newWorkout, id: formEntry.getId()))
            }
            newWorkoutList.append(newWorkout)
        }
        let encodedList = try! NSKeyedArchiver.archivedData(withRootObject: newWorkoutList, requiringSecureCoding: false)
        UserDefaults.standard.set(encodedList, forKey: Constants.userWorkoutsKey)
        
        
        print("Updated user workouts!")
        print(UserDefaults.standard.array(forKey: Constants.userWorkoutsKey));
        print(UserDefaults.standard.array(forKey: "blahblahblah"));
    }
}
