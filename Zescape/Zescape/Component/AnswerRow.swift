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
    
    var body: some View {
        HStack(spacing: 20)
        {
            if(answer.isSelected){
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
            
            
            if quizManager.isValidated && answer.isSelected {
                Spacer()
                
                Image(systemName: answer.isCorrect ? "checkmark.circle.fill" : "x.circle.fill")
                    .foregroundColor(answer.isCorrect ? .green : .red)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(quizManager.answerSelected ? (answer.isSelected && quizManager.isValidated ? Color("AccentColor") : .gray) : Color("AccentColor"))
        .background(.white)
        .cornerRadius(10)
        .shadow(color: answer.isSelected && quizManager.isValidated ? answer.isCorrect ? .green : .red : .gray, radius: 5, x: 0.5, y: 0.5)
    }
}

struct AnswerRow_Previews: PreviewProvider {
    static var previews: some View {
        AnswerRow(answer: Answer(text: "Single", isCorrect:  false, isSelected: false))
            .environmentObject(QuizManager())
    }
}
