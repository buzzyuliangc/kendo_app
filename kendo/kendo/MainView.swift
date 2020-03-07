//
//  MainView.swift
//  kendo
//
//  Created by Ian Loftis on 3/7/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI


struct MainView: View {
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        var enteredText: String
        return VStack {
            
            HStack {
                //TOOD: I think instead of a text field we want to have a custom text object or button with a box defined around it that takes them to the selection page when pressed
//                TextField("Workout Placeholder", text: enteredText)
                Button(action: {}) {
                    Text("Start")
                }
            }
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Button")
                }
            }
        }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
