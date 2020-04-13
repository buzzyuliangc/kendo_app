//
//  DeleteButton.swift
//  kendo
//
//  Created by Buzz Cai on 3/12/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI

struct DeleteButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
          Text("Delete")
        }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton(action: {
            
        })
    }
}
