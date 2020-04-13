//
//  DetailWorkoutView.swift
//  kendo
//
//  Created by Buzz Cai on 3/12/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI

struct DetailWorkoutView: View {
    @Binding var showingWorkout: Bool
    @State var showingFormEditor = false
    @State var deletingForm = false
    @State var addNew = false
    @Binding var addingNewWorkout: Bool
    @Binding var workoutList: Array<WorkoutObject>
    //    @State var formList = Array<WorkoutFormEntry>()
    //    @State var selectedForm: WorkoutFormEntry? = nil
    let workout: WorkoutObject
    @State var formList: Array<WorkoutFormEntry>
    @State var selectedForm: WorkoutFormEntry
    @State var enteredWorkoutName: String
    
    var body: some View {
        
        //        formList = workout.getForms()
        print("RESETING FORM TO " + selectedForm.getForm())
        
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
                            
                            Spacer()
                            
                            EditButton(action: {
                                self.selectedForm = workoutFormEntry
                                print("SENDING EDIT FOR " + self.selectedForm.getForm())
                                self.showingFormEditor.toggle()
                            }).buttonStyle(BorderlessButtonStyle()).padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(30), bottom: CGFloat(0), trailing: CGFloat(0)))
                            
                            //                            Spacer()
                            
                            
                            DeleteButton(action: {
                                self.deletingForm.toggle()
                            }).padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(30), bottom: CGFloat(0), trailing: CGFloat(0)))
                            //.buttonStyle(PrimitiveButtonStyle())
                            
                            
                            //DeleteButton()
                        }
                    }.navigationBarItems(leading: self.addingNewWorkout == true ? AnyView(Button(action:{
                                                self.showingWorkout.toggle()
                                                }){
                                                Text("Cancel")
                    
                                                }) : AnyView(EmptyView()),
                                                                trailing: self.addingNewWorkout == true ? AnyView(Button(action: {
                    
                                                                    if(self.workout.getForms().count != 0) {
                                                                        print("SAVING NEW WORKOUT!")
                                                                        self.workoutList.append(self.workout)
                                                                    } else if (self.formList.count != 0) {
                                                                        for form in self.formList {
                                                                            self.workout.addForm(form: form)
                                                                        }
                                                                        self.workoutList.append(self.workout)
                                                                    }
                                                                    else {
                                                                        print("Not enough forms to save!")
                                                                        print(self.formList.count)
                                                                    }
                                                                    self.showingWorkout.toggle()
                                                                }) {
                                                                    Text("Save")
                                                                }) : AnyView(EmptyView())).navigationBarTitle(Text(self.workout.getName()), displayMode: .inline)
                    //                    .navigationBarItems(trailing: HStack{self.addingNewWorkout == true ? AnyView(Button(action:{
                    //
                    //                    }){
                    //                        Text("Cancel")
                    //
                    //                    }) : AnyView(EmptyView())
                    //                        Spacer()
                    //                        TextField(self.workout.getName(), text: self.$enteredWorkoutName)
                    //                        Spacer()
                    //                        self.addingNewWorkout == true ? AnyView(Button(action: {
                    //
                    //                                            if(self.workout.getForms().count != 0) {
                    //                                                print("SAVING NEW WORKOUT!")
                    //                                                self.workoutList.append(self.workout)
                    //                                            } else if (self.formList.count != 0) {
                    //                                                for form in self.formList {
                    //                                                    self.workout.addForm(form: form)
                    //                                                }
                    //                                                self.workoutList.append(self.workout)
                    //                                            }
                    //                                            else {
                    //                                                print("Not enough forms to save!")
                    //                                                print(self.formList.count)
                    //                                            }
                    //                                            self.showingWorkout.toggle()
                    //                                        }) {
                    //                                            Text("Save")
                    //                        }) : AnyView(EmptyView())})
                }
                //                NewFormButton()
                Button(action: {
                    //CREATE NEW FORM OBJECT AND PASS IT
                    
                    self.addNew = true;
                    self.showingFormEditor.toggle()
                }) {
                    Text("Add Form")
                }.padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(0), bottom: CGFloat(0), trailing: CGFloat(0)))
                
            }
        }.popover(isPresented: $showingFormEditor, content: {
            //                selectedForm = WorkoutFormEntry(form: Constants.defaultForm, frequency: Constants.defaultFrequency, restTime: Constants.defaultRestTime, numSwings: Constants.defaultSwingCount, parentWorkout: self.workout, id:self.workout.getForms().count)
            if(self.addNew) {
                //                selectedForm = WorkoutFormEntry(form: Constants.defaultForm, frequency: Constants.defaultFrequency, restTime: Constants.defaultRestTime, numSwings: Constants.defaultSwingCount, parentWorkout: self.workout, id:self.workout.getForms().count)
                //            }
                EditFormView(formObject: WorkoutFormEntry(form: Constants.defaultForm, frequency: Constants.defaultFrequency, restTime: Constants.defaultRestTime, numSwings: Constants.defaultSwingCount, parentWorkout: self.workout, id:self.workout.getForms().count),
                             formList: self.$formList,
                             showingEditFormView: self.$showingFormEditor,
                             addingNew: self.addNew,
                             selectedForm: Constants.defaultForm,
                             selectedSpeed: Constants.defaultSpeedSelection,
                             enteredSwings: String(Constants.defaultSwingCount),
                             enteredRestTime: String(Constants.defaultRestTime))
            } else {
                EditFormView(formObject: self.selectedForm, formList: self.$formList,  showingEditFormView: self.$showingFormEditor, addingNew: self.addNew, selectedForm: self.selectedForm.getForm(), selectedSpeed: self.selectedForm.getSpeedSelection(), enteredSwings: String(self.selectedForm.getNumSwings()), enteredRestTime: String(self.selectedForm.getRestTime()))
            }
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
        //        let workout = WorkoutObject.init()
        //        workout.addForm(form: WorkoutFormEntry.init(form: "Form1", frequency: 1.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 0))
        //        workout.addForm(form: WorkoutFormEntry.init(form: "Form2", frequency: 0.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 1))
        //        workout.addForm(form: WorkoutFormEntry.init(form: "Form3", frequency: 2.5, restTime: 15, numSwings: 10, parentWorkout: workout, id: 2))
        //        return DetailWorkoutView(workout: workout, formList: workout.getForms(), selectedForm: workout.getForms()[0])
        Text("Example")
    }
}
