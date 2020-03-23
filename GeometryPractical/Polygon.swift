//
//  Polygon.swift
//  GeometryPractical
//
//  Created by Trung Phan on 3/20/20.
//  Copyright © 2020 TrungPhan. All rights reserved.
//

import SwiftUI


struct PolygonView_Previews: PreviewProvider {
    static var previews: some View {
        PolygonView(sides: 8)
    }
}


//MARK: - Polygon

struct PolygonView: View {
    @State var sides: CGFloat
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                VStack {
                    Polygon(sides: sides)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.blue)
                        .animation(.easeIn(duration: 3))
                }
            }
            .frame(width: 200, height: 200, alignment: .center)
            Text("Tham khảo https://swiftui-lab.com/swiftui-animations-part1")
            Stepper("Change to", value: $sides, in: 0...100)
                .padding()
        }
        
    }
}


struct Polygon: Shape {
    var sides: CGFloat
    var animatableData: CGFloat {
        get { return sides }
        set { sides = newValue }
    }
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let height = min(rect.width, rect.height) / 2
        let extra: Int = Double(sides) != Double(Int(sides)) ? 1 : 0
        for i in 0..<Int(sides) + extra {
            let angle = CGFloat.pi * 2 / CGFloat(sides) * CGFloat(i)
            let point = CGPoint(x: center.x + cos(angle) * height, y: center.y + sin(angle) * height)
            if i == 0 {
                path.move(to: point)
            }else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}
