//
//  QuestionView.swift
//  Zescape
//
//  Created by Anthony on 04/07/2022.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var quizManager: QuizManagerVM
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            ProgressBar(progress: quizManager.progress)
            HStack {
                HStack {
                    Text("Quiz progression")
                    Text("\(quizManager.index + 1) sur \(quizManager.length)")
                        .foregroundColor(colorScheme == .dark ?Color.white:Color.black)
                        .font(Font.custom("Nunito-Regular", size: 12))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.bottom, 20.0)
            }
            
            
            HStack {
                VStack(alignment: .leading) {
                    Text("QUIZ TITLE")
                        .font(Font.custom("Nunito-Bold", size: 28))
                        .foregroundColor(colorScheme == .dark ?Color.white:Color.black)
                        .fontWeight(.heavy)
                }
                Spacer()
            }.padding(.bottom, 20.0)
            
            VStack(alignment: .leading, spacing: 20) {
                Text(quizManager.question)
                    .font(Font.custom("Nunito-Regular", size: 16))
                    .bold()
                
                VStack(alignment: .center) {
                    ForEach(quizManager.answerChoices, id: \.id) { answer in
                        AnswerRow(answer: answer)
                            .padding(.vertical, 10.0)
                            .environmentObject(quizManager)
                            .onTapGesture {
                                if(!quizManager.isValidated){
                                    quizManager.selectAnswer(answerId: answer.id)
                                }
                                
                            }
                    }
                    if(quizManager.isValidated){
                        Text(quizManager.labelForAnswer())
                    }
                    
                }.padding(.horizontal, 20.0)
                
            }
            
            if(quizManager.isValidated){
                
                
                Button {
                    quizManager.goToNextQuestion()
                    quizManager.setValidated(isVal: false)
                } label: {
                    PrimaryButton(text: "Suivant",
                                  foreground: quizManager.answerSelected ? Color.init(hex: "#FFFFFF")! : Color.init(hex:"#A8A29E") ?? Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 1.327),
                                  background: quizManager.answerSelected ? Color.init(hex: "#84C46C")! : Color.init(hex:"#E7E5E4") ?? Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 1.327))
                }.padding(.vertical, 40.0)
            }
            else{
                Button {
                    quizManager.setValidated(isVal: true)
                    
                } label: {
                    PrimaryButton(text: "Valider",
                                  foreground: quizManager.answerSelected ? Color.init(hex: "#FFFFFF")! : Color.init(hex:"#A8A29E") ?? Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 1.327),
                                  background: quizManager.answerSelected ? Color.init(hex: "#84C46C")! : Color.init(hex:"#E7E5E4") ?? Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 1.327))
                    
                }.padding(.vertical, 40.0)
                
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
            .environmentObject(QuizManagerVM())
    }
}
