//
//  AnswerRow.swift
//  Zescape
//
//  Created by Anthony on 04/07/2022.
//

import SwiftUI

struct AnswerRow: View {
    @EnvironmentObject var quizManager: QuizManager
    var answer: Answer
    @State private var isSelected = false
    
    var body: some View {
        HStack(spacing: 20)
                {
                    
                    if(isSelected){
                        Image(systemName: "circle.fill")
                            .foregroundColor(Color.init(hex: "#306B1E"))
                            .font(.caption)
                    }
                    else{
                        Image(systemName: "circle")
                            .foregroundColor(Color.init(hex: "#306B1E"))
                            .font(.caption)
                    }


                    
                    Text(answer.text)
                        .foregroundColor(Color.init(hex: "#306B1E"))
                        .font(Font.custom("Nunito-Regular", size: 18))

                    
                    if quizManager.isValidated && isSelected {
                        Spacer()
                        
                        Image(systemName: answer.isCorrect ? "checkmark.circle.fill" : "x.circle.fill")
                            .foregroundColor(answer.isCorrect ? .green : .red)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(quizManager.answerSelected ? (isSelected && quizManager.isValidated ? Color("AccentColor") : .gray) : Color("AccentColor"))
                .background(.white)
                .cornerRadius(10)
                .shadow(color: isSelected && quizManager.isValidated ? answer.isCorrect ? .green : .red : .gray, radius: 5, x: 0.5, y: 0.5)
                .onTapGesture {
                    if !quizManager.answerSelected {
                        isSelected = true
                        quizManager.selectAnswer(answer: answer, selected: true)

                    }
                }
        
//            else{
//                if(quizManager.previousSelectedAnswer.id != answer.id){
//                    //uncheck
//                    quizManager.selectAnswer(answer: answer, selected: true)
//                    isSelected = true
//
//                }
//            }
        
    }
}

struct AnswerRow_Previews: PreviewProvider {
    static var previews: some View {
        AnswerRow(answer: Answer(text: "Single", isCorrect:  false))
                    .environmentObject(QuizManager())
    }
}
