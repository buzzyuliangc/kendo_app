//
//  WorkoutView.swift
//  kendo
//
//  Created by Ian Loftis on 3/7/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI
// the main workout view
struct WorkoutView: View {
    //states trackers for tracking whether to change view
    @State var isActive: Bool = true
    @Binding var showWorkout: Bool
    @Binding var showSheet: Bool
//    @State var show = false
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
            //time counters
            Text("\(Int(self.activeWorkout.elapsedTime) / 60):\(Int(self.activeWorkout.elapsedTime) % 60 / 10)\(Int(self.activeWorkout.elapsedTime) % 10)").padding(EdgeInsets(top: 300, leading: 300, bottom: 0, trailing: 0))
            HStack() {
                //paused label
                if(isActive) {
                    Text("Paused").font(.largeTitle).hidden()
                } else {
                    Text("Paused").font(.largeTitle).foregroundColor(Color.red)
                }
            }
            if(self.activeWorkout.resting) {
                //resting label and counter
                HStack {
                    Text("Resting").bold().foregroundColor(Color.white)
                    Text("\(Int(self.activeWorkout.restTime - Int(self.activeWorkout.runningTime)) / 60):\(Int(self.activeWorkout.restTime - Int(self.activeWorkout.runningTime)) % 60 / 10)\(Int(self.activeWorkout.restTime - Int(self.activeWorkout.runningTime)) % 10)").foregroundColor(Color.white)
                }
            } else {
                Text("Resting Placeholder").hidden()
            }
            
            HStack{
                //swing counter
                Text(verbatim: self.activeWorkout.formName)
                
                Text(verbatim: "\(String(self.activeWorkout.swingNum))" + "/" + "\(String(self.activeWorkout.swingMax))")
            }.padding(EdgeInsets(top: 280, leading: 300, bottom: 0, trailing: 0))
            HStack {
                //form counter and name
                Text(verbatim: "Suburi \(self.activeWorkout.formIndex+1)/\(self.activeWorkout.numForms)")
            }.padding(EdgeInsets(top: 0, leading: 300, bottom: 300, trailing: 0))
            //pause button and resume
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
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).foregroundColor(.white).padding().background(Color.red).cornerRadius(8)
            //quit button
            
            if(!self.isActive) {
                Button(action: {
                    //TODO: add code to log the stats for this workout
                    self.showWorkout = false
                    self.showSheet = false
                }) {
                    Text("Quit")
                }.foregroundColor(.white).padding().background(Color.red).cornerRadius(8)            } else {
                Button(action: {
                    //ACTION TO POP VIEW
                }) {
                    Text("Quit")
                }.hidden()
            }
        }.background(Image("Swing-" + "\(self.activeWorkout.subSwing)").resizable()
            .frame(width: 420.0,height:500)).offset(y:-230)
        
//        .sheet(isPresented: $showingMain) {
//            MainView(workout: self.workout)
//
//        }.background(Image("suburi").resizable()
//            .frame(width: 420.0,height:500)).offset(y:-230)
        
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = WorkoutObject.init()
        workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 0))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 1))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 2))
        let activeWorkout = ActiveWorkoutStore.init(workout: workout)
        return WorkoutView(showWorkout: .constant(true), showSheet: .constant(false), workout: workout, activeWorkout: activeWorkout)
    }
}
