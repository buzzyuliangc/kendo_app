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
            //            if isActive {
            //                Text("Paused")
            //            }
            HStack() {
                if(isActive) {
                    Text("Paused").bold().hidden()
                } else {
                    Text("Paused").bold()
                }
            }
            Spacer().frame(height: 40)
            
            if(self.activeWorkout.resting) {
                //                var remainingRest =
                HStack {
                    Text("Resting").bold()
                    Text("\(Int(self.activeWorkout.restTime - Int(self.activeWorkout.runningTime)) / 60):\(Int(self.activeWorkout.restTime - Int(self.activeWorkout.runningTime)) % 60 / 10)\(Int(self.activeWorkout.restTime - Int(self.activeWorkout.runningTime)) % 10)")
                }
            } else {
                Text("Resting Placeholder").hidden()
            }
            
            Spacer().frame(height:20)
            Text("\(Int(self.activeWorkout.elapsedTime) / 60):\(Int(self.activeWorkout.elapsedTime) % 60 / 10)\(Int(self.activeWorkout.elapsedTime) % 10)")
            
            HStack{
                Text(verbatim: self.activeWorkout.formName)
                
                Text(verbatim: "\(String(self.activeWorkout.swingNum))" + "/" + "\(String(self.activeWorkout.swingMax))")
            }
            HStack {
                Text(verbatim: "Suburi \(self.activeWorkout.formIndex+1)/\(self.activeWorkout.numForms)")
            }
            
            Button<HStack>(action: {
                self.activeWorkout.toggle()
                self.isActive.toggle()
            }){
                HStack() {
                    if(!self.isActive) {
                        Text("Resume")
                    } else {
                        Text("Pause")
                    }
                }
            }
            
            if(!self.isActive) {
                Button(action: {
                    //ACTION TO POP VIEW
                }) {
                    Text("Quit")
                }
            } else {
                Button(action: {
                    //ACTION TO POP VIEW
                }) {
                    Text("Quit")
                }.hidden()
            }
            
            
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = WorkoutObject.init()
        workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.5, restTime: 15, numSwings: 10, parentWorkout: workout))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout))
        let activeWorkout = ActiveWorkoutStore.init(workout: workout)
        return WorkoutView(workout: workout, activeWorkout: activeWorkout)
    }
}
