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
        VStack(spacing: 30){
            Spacer()
            ProgressBar(progress: quizManager.progress)
            HStack {
                HStack {
                    Text("Quiz progression")
                    Text("\(quizManager.index + 1) sur \(quizManager.length)")
                        .foregroundColor(colorScheme == .dark ?Color.white:Color.black)
                        .font(Font.custom("Nunito-Regular", size: 12))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.top, -20.0)
            }
            
            
            HStack {
                VStack(alignment: .leading) {
                    Text("QUIZ TITLE")
                        .font(Font.custom("Nunito-Bold", size: 28))
                        .foregroundColor(colorScheme == .dark ?Color.white:Color.black)
                        .fontWeight(.heavy)
                }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text(quizManager.question)
                    .font(Font.custom("Nunito-Regular", size: 16))
                    .bold()
                
                ForEach(quizManager.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(quizManager)
                        .onTapGesture {
                            quizManager.selectAnswer(answerId: answer.id)
                        }
                        
                }
            }
            
            if(quizManager.isValidated){
                Button {
                    quizManager.goToNextQuestion()
                    quizManager.setValidated(isVal: false)
                    
                } label: {
                    PrimaryButton(text: "Suivant", background: quizManager.answerSelected ? Color.init(hex: "#84C46C")! : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
                }
            }
            else{
                Button {
                    quizManager.setValidated(isVal: true)
                    
                } label: {
                    PrimaryButton(text: "Valider", background: quizManager.answerSelected ? Color.init(hex: "#84C46C")! : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
                }
                .disabled(!quizManager.answerSelected)
            }
            Spacer()
            
        }
        .navigationBarTitle("Quiz") // delete if you want no title
        .navigationBarTitleDisplayMode(.inline)
        .padding([.leading, .bottom, .trailing],17)
        
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(QuizManager())
    }
}
