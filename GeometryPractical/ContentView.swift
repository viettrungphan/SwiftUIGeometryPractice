//
//  ContentView.swift
//  GeometryPractical
//
//  Created by TrungPhan on 3/5/20.
//  Copyright © 2020 TrungPhan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Watch()
                .frame(width: 200, height: 200, alignment: .center)

            Text("Dwarves Foundation Looking for iOS, Golang, FE candidate.")
            CircleText(radius: 100, text: "Dwarves Foundation Looking for iOS, Golang, FE candidate.")

//            VStack {
//                PolygonView(sides: 3)
//                Image("geometry")
//                    .resizable()
//                    .frame(width: 300, height: 300)
//            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


