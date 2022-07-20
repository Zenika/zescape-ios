//
//  QuestionView.swift
//  Zescape
//
//  Created by Anthony on 04/07/2022.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var quizManager: QuizManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 40){
            
            ProgressBar(progress: quizManager.progress)
            HStack {
                VStack(alignment: .trailing) {
                    Text("\(quizManager.index + 1) sur \(quizManager.length)")
                        .foregroundColor(colorScheme == .dark ?Color.white:Color.black)
                        .fontWeight(.light)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                        Text("QUIZ TITLE")
                            .font(.title)
                            .foregroundColor(colorScheme == .dark ?Color.white:Color.black)
                            .fontWeight(.heavy)
                }
                Spacer()
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
            
            if(quizManager.isValidated){
                Button {
                    quizManager.goToNextQuestion()
                    quizManager.setValidated(isVal: false)

                } label: {
                    PrimaryButton(text: "Suivant", background: quizManager.answerSelected ? Color.init(hex: "#84C46C")! : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
                }
                //.disabled(!quizManager.answerSelected)
                Spacer()
            }
            else{
                Button {
                    quizManager.setValidated(isVal: true)

                } label: {
                    PrimaryButton(text: "Valider", background: quizManager.answerSelected ? Color.init(hex: "#84C46C")! : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
                }
                .disabled(!quizManager.answerSelected)
                Spacer()
            }
            
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
