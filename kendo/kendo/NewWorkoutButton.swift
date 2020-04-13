//
//  NewWorkoutButton.swift
//  kendo
//
//  Created by Buzz Cai on 3/12/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI

struct NewWorkoutButton: View {
    @State var showingDetailed = false
    @Binding var addingNewWorkout: Bool
    @Binding var workoutList: Array<WorkoutObject>
    var newWorkout = WorkoutObject.init()
    
    
    var body: some View {
        Button(action: {
            self.newWorkout.setName(name: "New Workout")
            self.showingDetailed.toggle()
            self.addingNewWorkout = true
            
            
        }) {
            Text("New Workout")
        }.sheet(isPresented: $showingDetailed) {
            
            DetailWorkoutView(showingWorkout: self.$showingDetailed, addingNewWorkout: self.$addingNewWorkout, workoutList: self.$workoutList, workout: self.newWorkout, formList: self.newWorkout.getForms(), selectedForm: WorkoutFormEntry(form: Constants.defaultForm, frequency: Constants.defaultFrequency, restTime: Constants.defaultRestTime, numSwings: Constants.defaultSwingCount, parentWorkout: self.newWorkout, id:0), enteredWorkoutName: self.newWorkout.getName())
                
            }
    }
}

struct NewWorkoutButton_Previews: PreviewProvider {
    static var previews: some View {
//        NewWorkoutButton()
        Text("no previews")
    }
}
