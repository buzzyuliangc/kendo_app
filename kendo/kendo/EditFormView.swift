//
//  EditFormView.swift
//  kendo
//
//  Created by Ian Loftis on 3/22/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI
//this view serves as the setting page for editing forms.
struct EditFormView: View {
    var formObject: WorkoutFormEntry
    @Binding var formList: Array<WorkoutFormEntry>
    @Binding var showingEditFormView: Bool
    
    @State var addingNew: Bool
    @State var pickingForm = false
    @State var selectedForm: String;
    @State var selectedSpeed: Int;
    @State var enteredSwings: String
    @State var enteredRestTime: String
    
    var body: some View {
        //        Picker()
        var form = formObject.getForm();
        
        print("ENTERING EDIT FOR " + selectedForm)
        
        return ZStack {
            VStack{
                //TODO: instead of padding here, change it to a minimum width and height so that it doesn't expand and contract on varying string lengths
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.showingEditFormView.toggle()
                    }) {
                        Text("Cancel")
                    }.foregroundColor(.white).padding().background(Color.red).cornerRadius(8)
                    Spacer()
                    
                    Button(action: {
                        self.formObject.setSpeedSelection(speedSelection: self.selectedSpeed)
                        self.formObject.setForm(form: self.selectedForm)
                        self.formObject.setNumSwings(numSwings: Int(self.enteredSwings)!)
                        self.formObject.setRestTime(restTime: Int(self.enteredRestTime)!)
                        if(self.addingNew) {
//                            print(self.formObject.getParentWorkout().getName())
//                            self.formObject.getParentWorkout().addForm(form: self.formObject)
                            self.formList.append(self.formObject)
                            self.addingNew = false
                            print("ADDING NEW FORM!")
                        }
                        self.showingEditFormView.toggle()
                    }) {
                        Text("Save")
                    }.foregroundColor(.white).padding().background(Color.green).cornerRadius(8)
                    Spacer()
                }
                
                HStack {
                    Text("Form: ")
                    Text("\(self.selectedForm)")
                        .padding(CGFloat(5))
                        .border(Color.black, width: CGFloat(1)).onTapGesture {
                            self.pickingForm.toggle()
                    }
                }
                
                HStack {
                    Text("Number of Swings: ")
                    TextField("Number of Swings", text: $enteredSwings)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad).background(Color.black.opacity(0.25)).frame(minWidth: CGFloat(80), maxWidth: CGFloat(80), minHeight: CGFloat(30), maxHeight: CGFloat(30))
                }
                
                HStack {
                    Text("Rest Time: ")
                    TextField("Rest Time", text: $enteredRestTime)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad).background(Color.black.opacity(0.25)).frame(minWidth: CGFloat(80), maxWidth: CGFloat(80), minHeight: CGFloat(30), maxHeight: CGFloat(30))
                }
                
                
                
                Picker(selection: $selectedSpeed, label: Text(""), content: {
                    ForEach(0 ..< Constants.speedOptions.count) { i in
                        Text(Constants.speedOptions[i])
                    }
                }).pickerStyle(SegmentedPickerStyle())
            }
            
            if(self.pickingForm) {
                VStack {
                    HStack {
                        Spacer()
                    }.frame(minWidth: CGFloat(0), maxWidth: .infinity, minHeight: CGFloat(0), maxHeight: .infinity, alignment: .topLeading)
                        .background(Color.black.opacity(0.5))
                    
                    //toolbar attempt
                    HStack{
                        Spacer()
                        Button(action: {
                            self.pickingForm.toggle()
                        }) {
                            Text("Done").padding(.trailing, 20)
                        }
                    }
                    
                    //creates picker
                    Picker(selection: $selectedForm, label: Text(Constants.formEditorFormPickerTitle)) {
                        ForEach(0 ..< Constants.forms.count) {
                            Text(Constants.forms[$0]).tag(Constants.forms[$0])
                        }
                    }.labelsHidden()
                }.onDisappear(perform: {
                    print("ON DISAPPEAR")
                    print(self.$selectedForm)
                })
            }
        }
    }
    
}

struct EditFormView_Previews: PreviewProvider {
    static var previews: some View {
        //        EditFormView()
        Text("Filler")
    }
}
