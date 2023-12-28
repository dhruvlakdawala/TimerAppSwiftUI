//
//  CircleProgress.swift
//  TimerAppPracticalTask
//
//  Created by Admin on 27/12/23.
//

import SwiftUI

//Create Custom CircleProgres View
struct CircleProgress: View {
    
    var progress: CGFloat //For progress of the timer
    var displayTime: String //Use for display the formatted time

    var body: some View {
        ZStack {
            //Background Circle
            Circle()
                .stroke(lineWidth: 10.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)

            //Front Circle
            Circle()
                .trim(from: 0.0, to: CGFloat(self.progress))
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            
            //Timing
            Text("\(self.displayTime)")
                .font(.system(size: 30))
                .padding()
        }
    }
}
