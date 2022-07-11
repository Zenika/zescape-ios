//
//  QuestionView.swift
//  Zescape
//
//  Created by Anthony on 04/07/2022.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var quizManager: QuizManager
    
    var body: some View {
        VStack(spacing: 40){
            
            ProgressBar(progress: quizManager.progress)

            HStack {
                Text("QUIZ GAME")
                    .foregroundColor(Color.red)
                    .fontWeight(.heavy)
                Spacer()
                Text("\(quizManager.index + 1) sur \(quizManager.length)")
                    .foregroundColor(Color.red)
                    .fontWeight(.heavy)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text(quizManager.question)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.gray)
                
                ForEach(quizManager.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(quizManager)
                }
            }
            
            Button {
                quizManager.goToNextQuestion()
            } label: {
                PrimaryButton(text: "Valider", background: quizManager.answerSelected ? Color("Brand Color") : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
            }
            .disabled(!quizManager.answerSelected)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(QuizManager())
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
