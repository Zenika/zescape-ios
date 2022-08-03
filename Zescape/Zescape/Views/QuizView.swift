//
//  QuizView.swift
//  Zescape
//
//  Created by Anthony on 07/07/2022.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var quizManager: QuizManagerVM
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
            if quizManager.reachedEnd {
                VStack(spacing: 20) {
                    if(quizManager.score >= 5 && quizManager.score < 10){
                        Text("Bravo 👏 ")
                            .font(Font.custom("Nunito-Regular", size: 28))
                        Text("Ton score est de \(quizManager.score) sur \(quizManager.length)")
                    }
                    else if(quizManager.score == 10){
                        Text("Waouh, c’est juste 👌 !")
                            .font(Font.custom("Nunito-Regular", size: 28))
                        Text("Ton score est de \(quizManager.score) sur \(quizManager.length)")
                    }
                    else if(quizManager.score >= 1 && quizManager.score < 5){
                        Text("C’est pas mal  🙂")
                            .font(Font.custom("Nunito-Regular", size: 28))
                        Text("Ton score est de \(quizManager.score) sur \(quizManager.length)")
                    }
                    else{
                        Text("Ce n’est pas si grave  🤗")
                            .font(Font.custom("Nunito-Regular", size: 28))
                        Text("Ton score est de \(quizManager.score) sur \(quizManager.length)")
                    }
                    
                    
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
                .toolbar {
                    ToolbarItem(placement: .principal) { // <3>
                        VStack {
                            Image("Logo")
                                
                        }
                    }
                }
            } else {
                QuestionView()
                    .environmentObject(quizManager)
            }
        }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
            .environmentObject(QuizManagerVM())
    }
}
