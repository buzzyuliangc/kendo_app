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
    @State var showingMain = false
    var workout: WorkoutObject
    
    
    @ObservedObject var activeWorkout: ActiveWorkoutStore
    
    var body: some View {
        self.activeWorkout.start()
        
        return VStack {
            //in this if statement we can include things to be shown
            //            if isActive {
            //                Text("Paused")
            //            }
            Spacer().frame(height:160)
            Text("\(Int(self.activeWorkout.elapsedTime) / 60):\(Int(self.activeWorkout.elapsedTime) % 60 / 10)\(Int(self.activeWorkout.elapsedTime) % 10)").padding(EdgeInsets(top: 250, leading: 300, bottom: 0, trailing: 0))
            HStack() {
                if(isActive) {
                    Text("Paused").font(.largeTitle).hidden()
                } else {
                    Text("Paused").font(.largeTitle).foregroundColor(Color.red)
                }
            }
            if(self.activeWorkout.resting) {
                //                var remainingRest =
                HStack {
                    Text("Resting").bold().foregroundColor(Color.white)
                    Text("\(Int(self.activeWorkout.restTime - Int(self.activeWorkout.runningTime)) / 60):\(Int(self.activeWorkout.restTime - Int(self.activeWorkout.runningTime)) % 60 / 10)\(Int(self.activeWorkout.restTime - Int(self.activeWorkout.runningTime)) % 10)").foregroundColor(Color.white)
                }
            } else {
                Text("Resting Placeholder").hidden()
            }
            
            HStack{
                Text(verbatim: self.activeWorkout.formName)
                
                Text(verbatim: "\(String(self.activeWorkout.swingNum))" + "/" + "\(String(self.activeWorkout.swingMax))")
            }.padding(EdgeInsets(top: 300, leading: 300, bottom: 0, trailing: 0))
            HStack {
                Text(verbatim: "Suburi \(self.activeWorkout.formIndex+1)/\(self.activeWorkout.numForms)")
            }.padding(EdgeInsets(top: 0, leading: 300, bottom: 0, trailing: 0))
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
            }.padding(EdgeInsets(top: 300, leading: 0, bottom: 0, trailing: 0))
            
            if(!self.isActive) {
                Button(action: {
                    self.showingMain.toggle()
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
        }.sheet(isPresented: $showingMain) {
            MainView(workout: self.workout)
            
        }.background(Image("suburi").resizable()
            .frame(width: 420.0,height:500)).offset(y:-230)
        
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = WorkoutObject.init()
        workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 0))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 1))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 2))
        let activeWorkout = ActiveWorkoutStore.init(workout: workout)
        return WorkoutView(workout: workout, activeWorkout: activeWorkout)
    }
}
