//
//  DetailWorkoutView.swift
//  kendo
//
//  Created by Buzz Cai on 3/12/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI
//shows all the forms in the workout and ability to edit or remove them
struct DetailWorkoutView: View {
    @Binding var showingWorkout: Bool
    @State var showingFormEditor = false
    @State var deletingForm = false
    @State var addNew = false
    @Binding var addingNewWorkout: Bool
    @Binding var workoutList: Array<WorkoutObject>
    let workout: WorkoutObject
    @State var formList: Array<WorkoutFormEntry>
    @State var selectedForm: WorkoutFormEntry
    @State var enteredWorkoutName: String
    
    var body: some View {
        
        return NavigationView {
            VStack{
                HStack{
                    List(formList, id: \.id) { workoutFormEntry in
                        HStack {
                            Button(action: {
                            }) {
                                Text(workoutFormEntry.getForm())
                            }.foregroundColor(.white).padding().background(Color.gray).cornerRadius(8)
                            
                            Spacer()
                            
                            EditButton(action: {
                                self.selectedForm = workoutFormEntry
                                print("SENDING EDIT FOR " + self.selectedForm.getForm())
                                self.showingFormEditor.toggle()
                            }).buttonStyle(BorderlessButtonStyle()).foregroundColor(.white).padding().background(Color.accentColor).cornerRadius(8).padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(0), bottom: CGFloat(0), trailing: CGFloat(0)))
                            
                            DeleteButton(action: {
                                self.deletingForm.toggle()
                            }).padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(0), bottom: CGFloat(0), trailing: CGFloat(0))).foregroundColor(.white).padding().background(Color.red).cornerRadius(8)                            //.buttonStyle(PrimitiveButtonStyle())
                        }
                    }.navigationBarTitle(Text(self.workout.getName()), displayMode: .inline)
                }
                Button(action: {
                    //CREATE NEW FORM OBJECT AND PASS IT
                    
                    self.addNew = true;
                    self.showingFormEditor.toggle()
                }) {
                    Text("Add Form")
                }.foregroundColor(.white).padding().background(Color.green).cornerRadius(8).padding(EdgeInsets(top: CGFloat(0), leading: CGFloat(0), bottom: CGFloat(0), trailing: CGFloat(0)))
                
            }
        }.popover(isPresented: $showingFormEditor, content: {
            if(self.addNew) {
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
    }
    
    func delete(at offsets: IndexSet) {
        
    }
}

struct DetailWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Example")
    }
}
