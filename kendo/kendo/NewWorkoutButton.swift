//
//  NewWorkoutButton.swift
//  kendo
//
//  Created by Buzz Cai on 3/12/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI

struct NewWorkoutButton: View {
    @State var showingDetailed = false
    var body: some View {
        Button(action: {self.showingDetailed.toggle()}) {
          Text("New Workout")
        }.sheet(isPresented: $showingDetailed) {
            DetailWorkoutView(workout: WorkoutObject.init())
                
            }
    }
}

struct NewWorkoutButton_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutButton()
    }
}
