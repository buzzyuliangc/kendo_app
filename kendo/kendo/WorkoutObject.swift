//
//  WorkoutObject.swift
//  kendo
//
//  Created by Ian Loftis on 3/6/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import Foundation

class WorkoutObject: NSObject, NSCoding {
    
    //encodes the object to the NSCoder
    //this is used to store it as a Data object, notably with UserDefaults
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(forms, forKey: "forms")
    }
    
    required convenience init(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        let name = coder.decodeObject(forKey: "name") as! String
        let forms = coder.decodeObject(forKey: "forms") as! Array<WorkoutFormEntry>
        self.init(id: id, name: name, forms: forms)
    }
    
    var forms: Array<WorkoutFormEntry>
    var name: String //NSString??
    
    //TODO: either figure out how to work IDs into the way the user's workouts are handled
    //or don't use an ID at all. It might be possible to just avoid IDs because we're
    //basically just passing an array between views and selecting indeces from them
    //in the lists or just passing the objects themselves
    var id: Int
    
    override init() {
        self.forms = Array<WorkoutFormEntry>()
        self.name = String.init()
        self.id = Int.init()
    }
    
    init(id: Int, name: String, forms: Array<WorkoutFormEntry>) {
        self.id = id
        self.name = name
        self.forms = forms
    }
    
    init(fromWorkoutObject: WorkoutObject) {
        self.id = fromWorkoutObject.getId();
        self.name = fromWorkoutObject.getName();
        self.forms = Array<WorkoutFormEntry>()
        for workoutFormEntry in fromWorkoutObject.getForms() {
            self.forms.append(WorkoutFormEntry(fromWorkoutFormEntry: workoutFormEntry))
        }
    }
    
    func getForm(formIndex: Int) -> WorkoutFormEntry{
        return forms[formIndex]
    }
    
    func getForms() -> Array<WorkoutFormEntry>{
        return forms
    }
    
    func addForm(form: WorkoutFormEntry) -> Void {
        forms.append(form)
    }
    
    func getName() -> String {
        return name
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getId() -> Int {
        return id
    }
    
    func setId(id: Int) {
        self.id = id
    }
    
}
