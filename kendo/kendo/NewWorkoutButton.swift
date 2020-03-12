//
//  NewWorkoutButton.swift
//  kendo
//
//  Created by Buzz Cai on 3/12/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI

struct NewWorkoutButton: View {
    var body: some View {
        Button(action: {}) {
          Text("New Workout")
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct NewWorkoutButton_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkoutButton()
    }
}
