//
//  CountdownTimer.swift
//  Zescape
//
//  Created by Anthony on 04/08/2022.
//

import SwiftUI

let defaultTimeRemaining: CGFloat = 3600
let lineWith: CGFloat = 15
let radius: CGFloat = 90
let dotCount = 60
let dotLength: CGFloat = 3
var spaceLength: CGFloat = 0
let pi = Double.pi


struct CountdownTimer: View {
    
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = defaultTimeRemaining
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
            let circumerence: CGFloat = CGFloat(2.0 * pi) * radius
            spaceLength = circumerence / CGFloat(dotCount) - dotLength
        }
    
    var body: some View {
        VStack(spacing: 25) {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.7), style: StrokeStyle(lineWidth: 4, lineCap: .butt, lineJoin: .miter, miterLimit: 0, dash: [dotLength, spaceLength], dashPhase: 0))
                Circle()
                    .trim(from: 0, to: 1 - ((defaultTimeRemaining - timeRemaining) / defaultTimeRemaining))
                    .stroke(timeRemaining > 2400 ? Color.green : timeRemaining > 1200 ? Color.yellow : Color.red, style: StrokeStyle(lineWidth: 4, lineCap: .butt, lineJoin: .miter))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut)
                
                VStack {
                    Text("Il vous reste")                        .font(Font.custom("Nunito-Regular", size: 10))
                    Text(timeString(time: TimeInterval(Int(timeRemaining)))).font(.largeTitle)
                }

            }.frame(width: radius * 2, height: radius * 2)
            .onAppear(perform:  {
                isActive.toggle()
            })
        }.onReceive(timer, perform: { _ in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isActive = false
                timeRemaining = defaultTimeRemaining
            }
        })

    }
    
    func timeString(time: TimeInterval) -> String {
            let hour = Int(time) / 3600
            let minute = Int(time) / 60 % 60
            let second = Int(time) % 60

            // return formated string
            return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
}



struct CountdownTimer_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimer()
    }
}
