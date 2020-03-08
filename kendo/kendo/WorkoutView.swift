//
//  WorkoutView.swift
//  kendo
//
//  Created by Ian Loftis on 3/7/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI

struct WorkoutView: View {
    @State var isActive: Bool = true
    
    var workout: WorkoutObject
    
    
    @ObservedObject var activeWorkout: ActiveWorkoutStore
    
    var body: some View {
        self.activeWorkout.start()
        
        return VStack {
            //in this if statement we can include things to be shown
            if(!self.isActive) {
                Text("Paused").padding(20)
            } else {
                Text("Paused").padding(20).hidden()
            }
            Text("\(Int(self.activeWorkout.elapsedTime) / 60):\(Int(self.activeWorkout.elapsedTime) % 60 / 10)\(Int(self.activeWorkout.elapsedTime) % 10)")
            
            HStack {
                Text("\(self.activeWorkout.formName)")
                
                Text("\(self.activeWorkout.swingNum)/\(self.activeWorkout.swingMax)")
            }
            HStack {
                Text("Suburi \(self.activeWorkout.formIndex+1)/\(self.activeWorkout.numForms)")
            }
            
            Button(action: {
                self.activeWorkout.toggle()
                self.isActive.toggle()
            }) {
                if(self.isActive) {
                    Text("Pause")
                } else {
                    Text("Resume")
                }
            }
            if(!self.isActive) {
                Button(action: {
                    //ACTION TO POP VIEW
                })
            }
            if(self.activeWorkout.resting) {
                var remainingRest = self.activeWorkout.restTime - self.activeWorkout.runningTime
                HStack {
                    Text("Resting")
                   
//                Text("\(Int(self.activeWorkout.runningTime) / 60):\(Int(self.activeWorkout.runningTime) % 60 / 10)\(Int(self.activeWorkout.runningTime) % 10)")
                    Text("\(Int(remainingRest) / 60):\(Int(remainingRest) % 60 / 10)\(Int(remainingRest) % 10)")
                }
            }
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = WorkoutObject.init()
        workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.0, restTime: 15, numSwings: 10, parentWorkout: workout))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 1.0, restTime: 15, numSwings: 10, parentWorkout: workout))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 1.0, restTime: 15, numSwings: 10, parentWorkout: workout))
        let activeWorkout = ActiveWorkoutStore.init(workout: workout)
        return WorkoutView(workout: workout, activeWorkout: activeWorkout)
    }
}
