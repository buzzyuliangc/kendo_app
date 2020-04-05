//
//  MainView.swift
//  kendo
//
//  Created by Ian Loftis on 3/7/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var showingMain = true
    @State var showingWorkout = false
    @State var showingEditWorkout = false
    @State var showModel = false
    //@ObservedObject var activeWorkout: ActiveWorkoutStore
    
    //TODO: I think making this variable a state will cause
    //it to auto update when we push back to this with
    //a new selection
    @State var workout: WorkoutObject
    var body: some View {
        let activeWorkout = ActiveWorkoutStore.init(workout: workout)
        
        return VStack {
            Spacer()
            Text("Kendo Time!").font(.largeTitle).foregroundColor(Color.gray)
            Spacer().frame(height:150)
            WorkoutPreviewView(workout: workout).frame(height:160)
            Spacer().frame(height:150)
            HStack {
                //TOOD: I think instead of a text field we want to have a custom text object or button with a box defined around it that takes them to the selection page when pressed

                Spacer()
                
                Button(action: {
                    self.showingEditWorkout = true
                    self.showingWorkout = false
                    self.showModel = true
                        
                }) {
                    Text("\(workout.getName())").foregroundColor(Color.white)
                }
                Button(action: {
                    self.showingWorkout = true
                    self.showingEditWorkout = false
                    self.showModel = true
                        
                }) {
                    Text("Start")
                }
                Spacer()
            }
            HStack {
                Button(action: {}) {
                    Text("Stats")
                }
                Button(action: {}) {
                    Text("Reminders")
                }
            }
            //Spacer()
            //Spacer()
        }.sheet(isPresented: $showModel, content: {
            if self.showingWorkout == true {
                WorkoutView(showWorkout: self.$showingWorkout, showSheet: self.$showModel, workout: self.workout, activeWorkout: activeWorkout)
            }
            if self.showingEditWorkout == true {
                EditWorkoutView(showSheet: self.$showModel, showEditWorkout: self.$showingEditWorkout, chosenWorkout: self.$workout, activeWorkout: activeWorkout)
            }


        }).background(MainBackground())
        
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        let workout = WorkoutObject.init()
        workout.setName(name: "Workout1")
        workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.5, restTime: 15, numSwings: 10, parentWorkout: workout, id:0))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id:1))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id:2))
        //let activeWorkout = ActiveWorkoutStore.init(workout: workout)
        return MainView(showingMain: true, showingWorkout: false, workout: workout)
    }
}
