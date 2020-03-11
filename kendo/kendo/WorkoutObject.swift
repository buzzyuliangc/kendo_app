//
//  WorkoutObject.swift
//  kendo
//
//  Created by Ian Loftis on 3/6/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import Foundation

class WorkoutObject: NSObject {
    var forms: Array<WorkoutFormEntry>
    var name: String //NSString??
    var id: Int
    
    override init() {
        self.forms = Array.init()
        self.name = String.init()
        self.id = Int.init()
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
