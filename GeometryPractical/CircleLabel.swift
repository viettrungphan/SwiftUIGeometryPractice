//
//  CircleLabel.swift
//  GeometryPractical
//
//  Created by Trung Phan on 3/18/20.
//  Copyright © 2020 TrungPhan. All rights reserved.
//

import Foundation
import SwiftUI
struct CircleText_Preview: PreviewProvider {
    static var previews: some View {
        CircleText(radius: 200, text: "Dwarves Foundation Looking for Golang, FE candidates")
    }
}

//MARK: - CircleLabel

struct CircleText: View {
    var data = Data()
    var radius: Double
    var text: String
    
    private var texts: [(offset: Int, element:Character)] {
        return Array(text.enumerated())
    }
    
    @State var textSizes: [Int:Double] = [:]
    
    
    
    var body: some View {
        ZStack {
            ForEach(self.texts, id: \.self.offset) { (offset, element) in
                VStack {
                    Text(String(element))
                        .background(Sizeable())
                        .onPreferenceChange(WidthPreferenceKey.self, perform: { size in
                            self.textSizes[offset] = Double(size + 3)
                        })
                    Spacer()
                }
                .rotationEffect(self.angle(at: offset))
                
            }
        }
        .frame(width: 300, height: 300, alignment: .center)
    }
    
    private func angle(at index: Int) -> Angle {
        guard let labelSize = textSizes[index] else {return .radians(0)}
        let percentOfLabelInCircle = labelSize / radius.perimeter
        let labelAngle = 2 * Double.pi * percentOfLabelInCircle
        
        
        let totalSizeOfPreChars = textSizes.filter{$0.key < index}.map{$0.value}.reduce(0,+)
        let percenOfPreCharInCircle = totalSizeOfPreChars / radius.perimeter
        let angleForPreChars = 2 * Double.pi * percenOfPreCharInCircle
        
        return .radians(angleForPreChars + labelAngle)
    }
    
}



extension Double {
    var perimeter: Double {
        return self * 2 * .pi
    }
}


//Get size for label helper
struct WidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat(0)
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
struct Sizeable: View {
    var body: some View {
        GeometryReader { geometry in
            return Rectangle()
                .foregroundColor(.clear)
                .preference(key: WidthPreferenceKey.self, value: geometry.size.width)
        }
    }
}
