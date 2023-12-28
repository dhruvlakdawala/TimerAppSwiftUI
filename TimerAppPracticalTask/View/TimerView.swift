//
//  TimerView.swift
//  TimerAppPracticalTask
//
//  Created by Admin on 27/12/23.
//

import SwiftUI
import UserNotifications

struct TimerView: View {
    
    @StateObject private var timerVM = TimerViewModel()

    var body: some View {
        VStack {
            //Headline
            Text("Timer Application")
                .font(.system(size: 35))
                .bold()
                .foregroundColor(Color.orange)
                .padding(.top, -100)
            
            //Bind custom circle progress
            CircleProgress(progress: timerVM.progress, displayTime: timerVM.formattedTime())
                .frame(width: 250, height: 250)
                .padding()

            HStack {
                //Start & Pause Button
                Button(action: {
                    if timerVM.isRunning {
                        timerVM.pause()
                    } else {
                        timerVM.start()
                    }
                }) {
                    Text(timerVM.isRunning ? "Pause" : "Start")
                        .padding()
                        .foregroundColor(.white)
                        .background(timerVM.isRunning ? Color.blue : Color.green)
                        .cornerRadius(10)
                }

                //Stop Button
                Button(action: {
                    timerVM.stop()
                }) {
                    Text("Stop")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
        }
        .onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        print("Notification authorization granted")
                    } else {
                        print("Notification authorization denied")
                    }
                }
        })
        .padding()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
