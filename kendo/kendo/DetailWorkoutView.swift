//
//  DetailWorkoutView.swift
//  kendo
//
//  Created by Buzz Cai on 3/12/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI

struct DetailWorkoutView: View {
    @State var showingWorkout = true
    @State var showingFormEditor = false
//    @State var selectedForm: WorkoutFormEntry? = nil
    let workout: WorkoutObject
    
    var body: some View {
        
        let formList = workout.getForms()
        var selectedForm = workout.getForms()[0]
        
        return NavigationView {
            VStack{
//                List {
//                    ForEach(formList, id: \.id) { workoutFormEntry in
//                        Text(workoutFormEntry.getForm())
//                        }.onDelete(perform: delete)
//                }
                HStack{
                    List(formList, id: \.id) { workoutFormEntry in
                        HStack {
                            Button(action: {
                            }) {
                                Text(workoutFormEntry.getForm())
                            }
                            //DeleteButton()
                        }
                    }.navigationBarTitle(Text("All Forms"), displayMode: .inline).navigationBarItems(leading: Button(action:{}){
                        Text("Cancel")
                        
                        }, trailing: Button(action:{}) {
                            Text("Save")
                    })
                    
                    List(formList, id: \.id) { workoutFormEntry in
                        HStack {
                            EditButton(action: {
                                selectedForm = workoutFormEntry
                                self.showingFormEditor.toggle()
                            })
                        }
                    }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                    
                    List(formList, id: \.id) { WorkoutFormEntry in
                        HStack {
                            DeleteButton()
                        }
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
//                NewFormButton()
                Button(action: {
                    //CREATE NEW FORM OBJECT AND PASS IT
                }) {
                  Text("Add Form")
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
            }
        }.popover(isPresented: $showingFormEditor, content: {
            EditFormView(formObject: selectedForm,  showingEditFormView: self.$showingFormEditor, selectedForm: selectedForm.getForm(), selectedSpeed: selectedForm.getSpeedSelection(), enteredSwings: String(selectedForm.getNumSwings()), enteredRestTime: String(selectedForm.getRestTime()))
            
        })
        //.sheet(isPresented: $showingWorkout){
        //            MainView(workout: self.chosenWorkout)
        //        }
    }
    
    func delete(at offsets: IndexSet) {
        
    }
}

struct DetailWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = WorkoutObject.init()
        workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 0))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 1))
        workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 2))
        return DetailWorkoutView(workout: workout)
    }
}
