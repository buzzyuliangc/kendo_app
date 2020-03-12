//
//  DetailWorkoutView.swift
//  kendo
//
//  Created by Buzz Cai on 3/12/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI

struct DetailWorkoutView: View {
    var body: some View {
        var workout = WorkoutObject.init()
        workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 0))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 1))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 2))
        var formList = workout.getForms()
        
        return NavigationView {
            VStack{
            HStack{
          List(formList, id: \.id) { WorkoutFormEntry in
            HStack {
              Button(action: {
              }) {
                Text(WorkoutFormEntry.getForm())
              }
              //DeleteButton()
            }
          }.navigationBarTitle(Text("All Forms"))
        List(formList, id: \.id) { WorkoutFormEntry in
          HStack {
            EditButton()
          }
                }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                List(formList, id: \.id) { WorkoutFormEntry in
                  HStack {
                    DeleteButton()
                  }
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            NewFormButton()
            }
        }//.sheet(isPresented: $showingMain){
         //   MainView(workout: self.chosenWorkout)
        //}
    }
}

struct DetailWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        DetailWorkoutView()
    }
}
