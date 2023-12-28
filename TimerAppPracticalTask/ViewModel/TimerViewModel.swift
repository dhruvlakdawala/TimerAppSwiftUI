//
//  TimerViewModel.swift
//  TimerAppPracticalTask
//
//  Created by Admin on 27/12/23.
//

import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    
    @Published var elapsedTime: TimeInterval = 60 //Use for timimg
    @Published var isRunning: Bool = false //Use for timer states
    @Published var progress: CGFloat = 1 //Use for show the timer progress
    
    private var objCancellable: Set<AnyCancellable> = []
    private var objTimer: Publishers.Autoconnect<Timer.TimerPublisher>?

    init() {
        objTimer = Timer.publish(every: 0.01, tolerance: 0.01, on: .main, in: .common, options: nil)
            .autoconnect()
    }

    //MARK: - Private Methods
    //Start Timer
    func start() {
        guard !isRunning else { return }
        objTimer?
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.elapsedTime <= 0.0 {
                    self.stop()
                    self.gettingNotification() //Notification getting while timer is ended and app is in background mode
                } else {
                    self.elapsedTime -= 0.01
                    self.progress = CGFloat(self.elapsedTime / 60)
                }
            }
            .store(in: &objCancellable)
        
        isRunning = true
    }
    
    //Pause Timer
    func pause() {
        self.objCancellable.removeAll()
        self.isRunning = false
    }

    //Stop Timer
    func stop() {
        self.objCancellable.removeAll()
        self.isRunning = false
        self.progress = 1
        self.elapsedTime = 60
    }
    
    //Formatted Time
    func formattedTime() -> String {
        let seconds = Int(elapsedTime) % 60
        let milliseconds = Int((elapsedTime.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d : %02d", seconds, milliseconds)
    }
    
    //Notification
    func gettingNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Message:"
        content.body = "Timer is finished........."

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: "timerEnded", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
