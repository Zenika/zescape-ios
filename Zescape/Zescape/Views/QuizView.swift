//
//  QuizView.swift
//  Zescape
//
//  Created by Anthony on 07/07/2022.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var quizManager: QuizManager

    var body: some View {
        if quizManager.reachedEnd {
            VStack(spacing: 20) {
                Text("Quiz Game")

                Text("Congratulations, you completed the game! 🥳")
                
                Text("You scored \(quizManager.score) out of \(quizManager.length)")
                
                Button {
                    Task.init {
                        await quizManager.fetchQuiz()
                    }
                } label: {
                    PrimaryButton(text: "Play again")
                }
            }
            .foregroundColor(Color.red)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.984313725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
        } else {
            QuestionView()
                .environmentObject(quizManager)
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
            .environmentObject(QuizManager())
    }
}
