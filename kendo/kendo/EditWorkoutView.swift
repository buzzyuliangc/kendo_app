//
//  EditWorkoutView.swift
//  kendo
//
//  Created by Buzz Cai on 3/10/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI

/*struct Workout: Identifiable {
  let id: Int
  let name: String
}*/

struct EditWorkoutView: View {
    @State var showingMain = false
    @State var chosenWorkout: WorkoutObject
    @ObservedObject var activeWorkout: ActiveWorkoutStore
    
    /*var workoutList = [
      Workout(id: 0, name: "Workout0"),
      Workout(id: 1, name: "Workout1"),
      Workout(id: 2, name: "Workout2"),
      Workout(id: 3, name: "Workout3"),
      Workout(id: 4, name: "Workout4"),
      Workout(id: 5, name: "Workout5"),
      Workout(id: 6, name: "Workout6"),
      Workout(id: 7, name: "Workout7"),
    ]*/
    var body: some View {
        var workoutList = [WorkoutObject]()
        for i in 1...5{
            let workout = WorkoutObject.init()
            workout.setName(name: "Workout"+String(i))
            workout.setId(id: i)
            workoutList.append(workout)
            workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 0))
            workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 1))
            workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 2))
        }
        
        return NavigationView {
            VStack{
            HStack{
          List(workoutList, id: \.id) { WorkoutObject in
            HStack {
              Button(action: {
                  self.showingMain.toggle()
                self.chosenWorkout = WorkoutObject
              }) {
                Text(WorkoutObject.getName())
              }
              //DeleteButton()
            }
          }.navigationBarTitle(Text("All Workouts"))
        List(workoutList, id: \.id) { WorkoutObject in
          HStack {
            EditButton()
          }
                }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                List(workoutList, id: \.id) { WorkoutObject in
                  HStack {
                    DeleteButton()
                  }
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            NewWorkoutButton()
            }
        }.sheet(isPresented: $showingMain){
            MainView(workout: self.chosenWorkout)
        }
    }
}

struct EditWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = WorkoutObject.init()
        workout.setName(name: "Workout1")
        workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.5, restTime: 15, numSwings: 10, parentWorkout: workout, id:0))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id:1))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id:2))
        let activeWorkout = ActiveWorkoutStore.init(workout: workout)
        return EditWorkoutView( chosenWorkout: workout,activeWorkout: activeWorkout)
    }
}
