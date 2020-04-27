//
//  WorkoutPreviewView.swift
//  kendo
//
//  Created by Ian Loftis on 3/22/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI
//this is the preview for workout that is showing up on menu
struct WorkoutPreviewView: View {
    var workout: WorkoutObject
    var formsString: String {
        let formList = workout.forms
        var tmpString = workout.getForms()[0].form
        for i in 1...workout.getForms().count-1 {
            tmpString += ", " + workout.getForms()[i].getForm()
        }
        return tmpString
    }
    
    // stats getters
    var averageRestString: String {
        let formList = workout.forms
        var sum = 0
        for form in formList {
            sum += form.getRestTime()
        }
        return String(Double(sum)/Double(formList.count)) + "s"
    }
    
    var swingCountString: String {
        let formList = workout.forms
        var sum = 0
        for form in formList {
            sum += form.getNumSwings()
        }
        return String(sum)
    }
    
    var durationString: String {
        let formList = workout.forms
        var sum = 0.0
        for form in formList {
            sum += form.frequency * Double(form.getNumSwings()) + Double(form.getRestTime())
        }
        return String(sum) + "s"
    }
    //form the view
    var body: some View {
        VStack {
            HStack {
                Text("\(workout.getName())").bold()
            }.padding(CGFloat(5))
            HStack {
                Text("Forms: ")
                Spacer()
                Text("\(formsString)")
                
            }.padding(CGFloat(5))
            HStack {
                Text("Total Swing Count:")
                Spacer()
                Text("\(swingCountString)")
            }.padding(CGFloat(5))
            HStack{
                Text("Average Rest Time: ")
                Spacer()
                Text("\(averageRestString)")
            }.padding(CGFloat(5))
            HStack {
                Text("Total Duration: ")
                Spacer()
                Text("\(durationString)")
                
            }.padding(CGFloat(5))
        }.frame(minWidth: 300, maxWidth: 300, minHeight: 160, maxHeight: 160).background(Color.white)
    }
}

struct WorkoutPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Filler")
    }
}
