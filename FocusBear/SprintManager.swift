//
//  SprintManager.swift
//  FocusBear
//
//  Created by Jhonatas Willian on 05/02/26.
//

import Foundation
import SwiftUI
internal import Combine

class SprintManager: ObservableObject {
    @Published var timeRemaining: TimeInterval = 25 * 60
    @Published var totalDuration: TimeInterval = 25 * 60
    @Published var isRunning = false
    @Published var isFinished = false
    
    private var timer: Timer?
    
    func startSprint(minutes: Int) {
        totalDuration = TimeInterval(minutes * 60)
        timeRemaining = totalDuration
        isRunning = true
        isFinished = false
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.completeSprint()
            }
        }
    }
    
    func pauseSprint() {
        isRunning = false
        timer?.invalidate()
    }
    
    func resumeSprint() {
        if timeRemaining > 0 {
            isRunning = true
            timer = Timer
                .scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    } else {
                        self.completeSprint()
                    }
                }
        }
    }
    
    func stopSprint() {
        isRunning = false
        isFinished = false
        timer?.invalidate()
        timeRemaining = 25 * 60
    }
    
    private func completeSprint() {
        timer?.invalidate()
        isRunning = false
        isFinished = true
    }
    
    func timeString() -> String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
