//
//  EditWorkoutView.swift
//  kendo
//
//  Created by Buzz Cai on 3/10/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//
//edit workout view displays all the workouts
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
//    let listData = UserDefaults.standard.data(forKey: Constants.userWorkoutsKey)
    @State var workoutList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(UserDefaults.standard.data(forKey: Constants.userWorkoutsKey)!) as! Array<WorkoutObject>
    @State var addingNewWorkout: Bool = false
    
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
        print("Is it there: ")
//        let listData = UserDefaults.standard.data(forKey: Constants.userWorkoutsKey)
//        var workoutList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(listData!) as! Array<WorkoutObject>
        
        return NavigationView {
            VStack{
                HStack{
                    List(workoutList, id: \.id) { workoutObject in
                        HStack {
                            Button(action: {
                                self.showingMain.toggle()
                                
                                self.chosenWorkout = workoutObject
                                UserDefaults.standard.set(self.chosenWorkout.id, forKey: Constants.userSelectedWorkoutKey)
                                
                                self.showSheet = false
                                self.showEditWorkout = false
                            }) {
                                Text(workoutObject.getName())
                            }.buttonStyle(BorderlessButtonStyle()).foregroundColor(.white).padding().background(Color.gray).cornerRadius(8)
                            
                            Spacer()
                            
                            NavigationLink(destination: DetailWorkoutView(showingWorkout: .constant(true), addingNewWorkout: .constant(false), workoutList: self.$workoutList, workout: workoutObject, formList: workoutObject.getForms(), selectedForm: (workoutObject.getForms() as Array<WorkoutFormEntry>)[0], enteredWorkoutName: workoutObject.getName())) {
                                Text("Edit")
                            }.foregroundColor(.white).padding().background(Color.accentColor).cornerRadius(8)
                            //                            Spacer()
                            
                            
                            DeleteButton(action: {
                                
                                }).padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(0), bottom: CGFloat(0), trailing: CGFloat(0))).buttonStyle(BorderlessButtonStyle()).foregroundColor(.white).padding().background(Color.red).cornerRadius(8)
                            //.buttonStyle(PrimitiveButtonStyle())
                            
                            
                            //DeleteButton()
                        }
                    }
                    
//                    List(workoutList, id: \.id) { WorkoutObject in
//                        HStack {
//                            Button(action: {
//                                self.showingMain.toggle()
//
//                                self.chosenWorkout = WorkoutObject
//                                UserDefaults.standard.set(self.chosenWorkout.id, forKey: Constants.userSelectedWorkoutKey)
//
//                                self.showSheet = false
//                                self.showEditWorkout = false
//                            }) {
//                                Text(WorkoutObject.getName())
//                            }
//                            //DeleteButton()
//                        }
//                    }.navigationBarTitle(Text("All Workouts"), displayMode: .inline)
//
//                    List(workoutList, id: \.id) { workoutObject in
////                        HStack {
////                            EditButton()
////                        DetailWorkoutView(showingWorkout: .constant(true), addingNewWorkout: self.$addingNewWorkout, workoutList: self.$workoutList, workout: workoutObject, formList: workoutObject.getForms(), selectedForm: (workoutObject.getForms() as Array<WorkoutFormEntry>)[0]) , enteredWorkoutName: workoutObject.getName()
//                        NavigationLink(destination: DetailWorkoutView(showingWorkout: .constant(true), addingNewWorkout: .constant(false), workoutList: self.$workoutList, workout: workoutObject, formList: workoutObject.getForms(), selectedForm: workoutObject.getForms()[0], enteredWorkoutName: workoutObject.getName())) {
//                                Text("Edit")
//                            }
////                        }
//                    }.padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(30), bottom: CGFloat(0), trailing: CGFloat(0)))
//
//                    List(workoutList, id: \.id) { WorkoutObject in
//                        HStack {
//                            DeleteButton(action: {
//
//                            })
//                        }
//                    }.padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(0), bottom: CGFloat(0), trailing: CGFloat(0)))
                }
                //new workout button
                NewWorkoutButton(addingNewWorkout: self.$addingNewWorkout, workoutList: self.$workoutList)
            }
        }.onDisappear(perform: {
            print("attempting to save workout list")
            saveWorkouts(workoutList: self.workoutList)
        })
    }
}
//save to device
func saveWorkouts(workoutList: Array<WorkoutObject>) -> Void{
    Helper.saveWorkoutList(workoutList: workoutList)
}

struct EditWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Test")
    }
}
