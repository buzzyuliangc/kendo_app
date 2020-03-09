//
//  PauseButton.swift
//  kendo
//
//  Created by Ian Loftis on 3/8/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI

struct PauseButton: View {
    @State var paused = false
    var body: some View {
        if(paused) {
            return Text("Resume")
        } else {
            return Text("Paused")
        }
    }
}

struct PauseButton_Previews: PreviewProvider {
    static var previews: some View {
        PauseButton()
    }
}
