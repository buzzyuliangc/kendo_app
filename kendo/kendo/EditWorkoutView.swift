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
    @Binding var showSheet: Bool
    @Binding var showEditWorkout: Bool
    @State var showingMain = false
    @Binding var chosenWorkout: WorkoutObject
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
        var workoutList: Array<WorkoutObject>
        let listData = UserDefaults.standard.data(forKey: Constants.userWorkoutsKey)
        workoutList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(listData!) as! Array<WorkoutObject>
        //        var workoutList = [WorkoutObject]()
        //        for i in 1...5{
        //            let workout = WorkoutObject.init()
        //            workout.setName(name: "Workout"+String(i))
        //            workout.setId(id: i)
        //            workoutList.append(workout)
        //            workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 0))
        //            workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 1))
        //            workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 2))
        //        }
        
        return NavigationView {
            VStack{
                HStack{
                    List(workoutList, id: \.id) { WorkoutObject in
                        HStack {
                            Button(action: {
                                self.showingMain.toggle()
                                
                                self.chosenWorkout = WorkoutObject
                                UserDefaults.standard.set(self.chosenWorkout.id, forKey: Constants.userSelectedWorkoutKey)
                                
                                self.showSheet = false
                                self.showEditWorkout = false
                            }) {
                                Text(WorkoutObject.getName())
                            }
                            //DeleteButton()
                        }
                    }.navigationBarTitle(Text("All Workouts"), displayMode: .inline)
                    
                    List(workoutList, id: \.id) { WorkoutObject in
//                        HStack {
//                            EditButton()
                            NavigationLink(destination: DetailWorkoutView(workout: WorkoutObject) ) {
                                Text("Edit")
                            }
//                        }
                    }.padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(30), bottom: CGFloat(0), trailing: CGFloat(0)))
                    
                    List(workoutList, id: \.id) { WorkoutObject in
                        HStack {
                            DeleteButton()
                        }
                    }.padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(0), bottom: CGFloat(0), trailing: CGFloat(0)))
                }
                NewWorkoutButton()
            }
        }.onDisappear(perform: {
            print("attempting to save workout list")
//            let encodedList = try! NSKeyedArchiver.archivedData(withRootObject: workoutList, requiringSecureCoding: false)
//            UserDefaults.standard.set(encodedList, forKey: Constants.userWorkoutsKey)
        })
        
        //        List(workoutList, id: \.id) { WorkoutObject in
        //          HStack {
        //            EditButton()
        //          }
        //                }.padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(30), bottom: CGFloat(0), trailing: CGFloat(0)))
        //                List(workoutList, id: \.id) { WorkoutObject in
        //                  HStack {
        //                    DeleteButton()
        //                  }
        //                }.padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(0), bottom: CGFloat(0), trailing: CGFloat(0)))
        //            }
        //            NewWorkoutButton()
        //            }
        //        }.sheet(isPresented: $showingMain){
        //            MainView(workout: self.chosenWorkout)
        //        }
    }
}

struct EditWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
//        let workout = WorkoutObject.init()
//        workout.setName(name: "Workout1")
//        workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.5, restTime: 15, numSwings: 10, parentWorkout: workout, id:0))
//        workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id:1))
//        workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id:2))
//        let activeWorkout = ActiveWorkoutStore.init(workout: workout)
//        return EditWorkoutView(showSheet: .constant(true), showEditWorkout: .constant(true), chosenWorkout: workout, activeWorkout: activeWorkout)
        Text("Test")
    }
}
