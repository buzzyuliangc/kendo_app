//
//  Constants.swift
//  kendo
//
//  Created by Ian Loftis on 3/22/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import Foundation

struct Constants {
    static let userWorkoutsKey = "UserWorkoutList"
    static let userSelectedWorkoutKey = "UserSelectedWorkout"
    static let forms = ["form1", "form2", "form3","form4","form5","form6","form7","form8","form9","form10"]
    //the idea is that this holds the counts making up a single "swing"
    static let formSwings = ["form1": [1,2,3]]
    
    static let defaultFrequency = 1.0
    static let defaultForm = "form1"
    static let defaultSwingCount = 10
    static let defaultRestTime = 30
    static let defaultSpeedSelection = 3
    static let formEditorFormPickerTitle = "Select Form"
    static let speedOptions = ["Slower", "Slow", "Mid", "Fast", "Faster"]
}
