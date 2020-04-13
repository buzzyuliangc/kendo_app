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
    static let forms = ["Form1", "Form2", "Form3","Form4","Form5","Form6","Form7","Form8","Form9","Form10"]
    //the idea is that this holds the counts making up a single "swing"
    static let formSubSwings = ["Form1": [1,2],
                                "Form2": [1,2],
                                "Form3": [1,2],
                                "Form4": [1,2],
                                "Form5": [1,2],
                                "Form6": [1,2],
                                "Form7": [1,2],
                                "Form8": [1,2],
                                "Form9": [1,2],
                                "Form10": [1,2]]
    
    static let numberFiles = [1: "1sound.mp3",
                          2: "2sound.mp3",
                          3: "3sound.mp3",
                          4: "4sound.mp3",
                          5: "5sound.mp3",
                          6: "6sound.mp3",
                          7: "7sound.mp3",
                          8: "8sound.mp3",
                          9: "9sound.mp3",
                          10: "10sound.mp3"]
    
    static let defaultFrequency = 1.0
    static let defaultForm = "Form1"
    static let defaultSwingCount = 10
    static let defaultRestTime = 30
    static let defaultSpeedSelection = 3
    static let formEditorFormPickerTitle = "Select Form"
    static let speedOptions = ["Slower", "Slow", "Mid", "Fast", "Faster"]
}
