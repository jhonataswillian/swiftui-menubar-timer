//
//  MainView.swift
//  FocusBear
//
//  Created by Jhonatas Willian on 05/02/26.
//

import Foundation
import SwiftUI

struct MainView: View {
    @ObservedObject var manager: SprintManager
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("🐻 Focus Bear")
                .font(.headline)
                .opacity(0.8)
            
            Divider()
            
            if manager.isFinished {
                VStack(spacing: 12) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.yellow)
                    
                    Text("Well done!")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("You focused for \(Int(manager.totalDuration / 60)) minutes.")
                        .multilineTextAlignment(.center)
                        .font(.body)
                    
                    Button("New Sprint") {
                        manager.stopSprint()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                
            } else if manager.isRunning || manager.timeRemaining < manager.totalDuration {
                VStack(spacing: 10) {
                    Text(manager.timeString())
                        .font(.system(size: 48).monospacedDigit())
                    
                    HStack {
                        Button(manager.isRunning ? "Pause" : "Resume") {
                            if manager.isRunning {
                                manager.pauseSprint()
                            } else {
                                manager.resumeSprint()
                            }
                        }
                        
                        Button("Stop") {
                            manager.stopSprint()
                        }
                        .foregroundColor(.red)
                    }
                }
                .padding()
                
            } else {
                // TELA 1: Escolha (English)
                VStack(spacing: 10) {
                    Text("Ready to focus?")
                        .font(.subheadline)
                    
                    HStack {
                        Button("10 m") { manager.startSprint(minutes: 10) }
                        Button("25 m") { manager.startSprint(minutes: 25) }
                        Button("50 m") { manager.startSprint(minutes: 50) }
                        Button(" ⚡️ ") { manager.startSprint(minutes: 01) }
                    }
                    .controlSize(.large)
                }
                .padding()
            }
        }
        .padding()
        .frame(width: 260)
    }
}

#Preview {
    MainView(manager: SprintManager())
}
