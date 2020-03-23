//
//  Watch.swift
//  GeometryPractical
//
//  Created by Trung Phan on 3/18/20.
//  Copyright © 2020 TrungPhan. All rights reserved.
//

import Foundation
import SwiftUI


//MARK: - Watch

struct Watch_Preview: PreviewProvider {
    static var previews: Watch {
        Watch()
    }
}

struct Watch: View {
    @State var date:Date = Date()
    
    var body: some View {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        
        //Convert Date to angle
        var minuteAngle:Double = 0
        var hourAngle:Double = 0
        var secondAngle: Double = 0
        
        
        if let hour =  dateComponents.hour,
            let minute = dateComponents.minute,
            let second = dateComponents.second {
            
            let radianInOneHour = 2 * Double.pi / 12
            let radianInOneMinute = 2 * Double.pi / 60
            
            minuteAngle = Double(minute) * radianInOneMinute
            
            let actualHour = Double(hour) + (Double(minute)/60)
            
            hourAngle = actualHour * radianInOneHour
            
            secondAngle = Double(second) * radianInOneMinute
        }
        
        return ZStack{
            //            Circle().fill(Color.green)
            Arc()
                .stroke(lineWidth: 3)

            Ticks()
            Numbers()
            Circle()
                .fill()
                .frame(width: 15, height: 15, alignment: .center)
            //Hour hand
            Hand(offSet: 40)
                .fill()
                .frame(width: 4, alignment: .center)
                .rotationEffect(.radians(hourAngle))

            //Minute hand
            Hand(offSet: 10)
                .fill()
                .frame(width: 3, alignment: .center)
                .rotationEffect(.radians(minuteAngle))
            
            //Second hand
            Hand(offSet: 5)
                .fill()
                .foregroundColor(.red)
                .frame(width: 2, alignment: .center)
                .rotationEffect(.radians(secondAngle))

            Circle()
                .fill()
                .foregroundColor(.red)
                .frame(width: 7, height: 7, alignment: .center)
        }
        .frame(width: 200, height: 200, alignment: .center)
        .onAppear(perform: start)
    }
    
    func start() {
        Timer.scheduledTimer(withTimeInterval: 1 /*3*/, repeats: true) { _ in
            self.date = Date()
            /*
             withAnimation(.spring()) {
             self.date = Date()
             }
             */
        }
    }
}

struct Arc: Shape {

    var startAngle: Angle = .radians(0)
    var endAngle: Angle = .radians(Double.pi * 2)
    var clockWise: Bool = true
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width/2, rect.height/2)
        
        path.addArc(center:  center, radius: radius , startAngle: startAngle, endAngle: endAngle, clockwise: clockWise)
        return path
    }
}

struct Circle:  Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}

struct Hand: Shape {
    var offSet: CGFloat = 0
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(in: CGRect(origin: CGPoint(x: rect.origin.x, y: rect.origin.y + offSet), size: CGSize(width: rect.width, height: rect.height/2 - offSet)), cornerSize: CGSize(width: rect.width/2, height: rect.width/2))
        return path
    }
}

struct Ticks: View {
    var body: some View {
        ZStack {
            ForEach(0..<60) { position in
                Tick(isLong: position % 5 == 0 )
                    .stroke(lineWidth: 2)
                    .rotationEffect(.radians(Double.pi*2 / 60 * Double(position)))
                
            }
        }
    }
}

struct Tick: Shape {
    var isLong: Bool = false
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x:rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x:rect.midX, y: rect.minY + 5 + (isLong ? 5 : 0) ))
        return path
    }
}

struct Numbers: View {
    var body: some View {
        ZStack{
            ForEach(1..<13) { hour in
                Number(hour: hour)
            }
            
        }
    }
}

struct Number: View {
    var hour: Int
    var body: some View {
        VStack {
            Text("\(hour)").fontWeight(.bold)
                .rotationEffect(.radians(-(Double.pi*2 / 12 * Double(hour))))
            Spacer()
        }
        .padding()
        .rotationEffect(.radians( (Double.pi*2 / 12 * Double(hour))))
    }
}
