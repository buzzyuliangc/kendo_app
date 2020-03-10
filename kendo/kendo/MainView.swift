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
    
    var body: some View {
        //        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        var enteredText: String
        
        let workout = WorkoutObject.init()
        workout.setName(name: "Workout1")
        workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.0, restTime: 15, numSwings: 10, parentWorkout: workout))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 1.0, restTime: 15, numSwings: 10, parentWorkout: workout))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 1.0, restTime: 15, numSwings: 10, parentWorkout: workout))
        let activeWorkout = ActiveWorkoutStore.init(workout: workout)
        
        return VStack {
            Spacer()
            Text("Kendo Time!").font(.largeTitle).foregroundColor(Color.gray)
            Spacer().frame(height:460)
            HStack {
                //TOOD: I think instead of a text field we want to have a custom text object or button with a box defined around it that takes them to the selection page when pressed
//                TextField("Workout Placeholder", text: enteredText)
                Spacer()
                
                Button(action: {
                    self.showingEditWorkout.toggle()
                }) {
                    Text("\(workout.getName())").foregroundColor(Color.white)
                }
                Button(action: {
                    self.showingWorkout.toggle()
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
        }.sheet(isPresented: $showingWorkout) {
        //                    WorkoutView(workout: workout, activeWorkout: activeWorkout)
            WorkoutView(workout: workout, activeWorkout: activeWorkout)
            
        }.sheet(isPresented: $showingEditWorkout){
            EditWorkoutView()
        }.background(MainBackground())
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
