//
//  MainBackground.swift
//  kendo
//
//  Created by Buzz Cai on 3/8/20.
//  Copyright © 2020 401_group_8. All rights reserved.
//

import SwiftUI

struct MainBackground: View {
    var body: some View {
        Image("front_page_image")
            .resizable()
            .frame(width: 700.0,height:910)
            .offset(x:30)
        
    }
}

struct MainBackground_Previews: PreviewProvider {
    static var previews: some View {
        MainBackground()
    }
}
