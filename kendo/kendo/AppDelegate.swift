//
//  AppDelegate.swift
//  kendo
//
//  Created by Buzz Cai on 2/21/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //TODO: check to see if a workout list object exists in the NSUserDefaults (or equivalent)
        //      and if one doesn't, create a default one
        
        //TODO: MAKE A CONSTANT GLOBAL STRINGS FILE << DONE!
        //TODO: See about instantiating global default workouts elsewhere
        //TODO: PROBABLY WANT TO INSTANTIATE GLOBAL DEFAULT WORKOUTS ELSEWHERE, THIS IS LOADING DEFAULTS EVERY TIME!
        
        if(UserDefaults.standard.array(forKey: Constants.userWorkoutsKey) == nil) {
            var workoutList = Array<WorkoutObject>()
            
            //First example workout
            var workout = WorkoutObject.init()
            workout.setName(name: "Example 1")
            workout.setId(id: 0)
            workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 0))
            workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 1))
            workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 2))
            
            workoutList.append(workout)
            
            //Second example workout
            workout = WorkoutObject.init()
            workout.setName(name: "Example 2")
            workout.setId(id: 1)
            workout.addForm(form: WorkoutFormEntry.init(form: "Form5", frequency: 1.8, restTime: 15, numSwings: 10, parentWorkout: workout, id: 0))
            workout.addForm(form: WorkoutFormEntry.init(form: "Form9", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 1))
            workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 2))
            
            workoutList.append(workout)
            
            //Third Example Workout
            workout = WorkoutObject.init()
            workout.setName(name: "Example 3")
            workout.setId(id: 2)
            workout.addForm(form: WorkoutFormEntry.init(form: "Form10", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 0))
            workout.addForm(form: WorkoutFormEntry.init(form: "Form9", frequency: 1.0, restTime: 15, numSwings: 10, parentWorkout: workout, id: 1))
            workout.addForm(form: WorkoutFormEntry.init(form: "Form8", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 2))
            
            workoutList.append(workout)
            
//            let encodedList = try! NSKeyedArchiver.archivedData(withRootObject: workoutList, requiringSecureCoding: false)
//            UserDefaults.standard.set(encodedList, forKey: Constants.userWorkoutsKey)
            Helper.saveWorkoutList(workoutList: workoutList)
            print("saved default workout list!")
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

