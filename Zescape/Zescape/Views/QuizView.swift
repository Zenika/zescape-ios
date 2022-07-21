//
//  QuizView.swift
//  Zescape
//
//  Created by Anthony on 07/07/2022.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var quizManager: QuizManager
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
            if quizManager.reachedEnd {
                VStack(spacing: 20) {
                    Text("Bravo ! 🥳")
                        .font(Font.custom("Nunito-Regular", size: 28))
                    
                    Text("Votre score est de \(quizManager.score) sur \(quizManager.length)")
                    
                    NavigationLink {
                         HomeView()
                    } label: {
                        PrimaryButton(text: "Revenir à l'écran d'accueil")
                    }
                }
                .foregroundColor(colorScheme == .dark ?Color.white:Color.black)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(colorScheme == .dark ?Color.black:Color.white)
                .navigationBarTitle("Quiz") // delete if you want no title
                .navigationBarTitleDisplayMode(.inline)
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
