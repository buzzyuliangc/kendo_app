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
    
    //it to auto update when we push back to this with
    //a new selection
    @State var workout: WorkoutObject
    var body: some View {
        let activeWorkout = ActiveWorkoutStore.init(workout: workout)
        //init new workout
        return VStack {
            //main menu layout
            Spacer()
            Text("Kendo Time!").font(.largeTitle).foregroundColor(Color.gray)
            Spacer().frame(height:150)
            WorkoutPreviewView(workout: workout).frame(height:160)
            Spacer().frame(height:150)
            HStack {
                

                Spacer()
                
                Button(action: {
                    self.showingEditWorkout = true
                    self.showingWorkout = false
                    self.showModel = true
                        
                }) {
                    Text("\(workout.getName())")
                }.foregroundColor(.white).padding().background(Color.gray).cornerRadius(8)
                Button(action: {
                    self.showingWorkout = true
                    self.showingEditWorkout = false
                    self.showModel = true
                        
                }) {
                    Text("Start")
                }.foregroundColor(.white).padding().background(Color.green).cornerRadius(8)
                Spacer()
            }
            HStack {
                //these two buttons are not implemented yet
                Button(action: {}) {
                    Text("Stats")
                }.foregroundColor(.white).padding().background(Color.red).cornerRadius(8)
                Button(action: {}) {
                    Text("Reminders")
                }.foregroundColor(.white).padding().background(Color.accentColor).cornerRadius(8)
                
            }
            //Spacer()
            //Spacer()
        }.sheet(isPresented: $showModel, content: {//change view
            if self.showingWorkout == true {
                WorkoutView(showWorkout: self.$showingWorkout, showSheet: self.$showModel, workout: self.workout, activeWorkout: activeWorkout)
            }
            if self.showingEditWorkout == true {//change view
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
