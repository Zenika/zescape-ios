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
                    if(quizManager.score >= 7 && quizManager.score < 10){
                        Text("Bravo 👏 ")
                            .font(Font.custom("Nunito-Regular", size: 28))
                        Text("Ton score est de \(quizManager.score) sur \(quizManager.length)")
                    }
                    else if(quizManager.score == 10){
                        Text("Waouh, c’est juste 👌 !")
                            .font(Font.custom("Nunito-Regular", size: 28))
                        Text("Ton score est de \(quizManager.score) sur \(quizManager.length)")
                    }
                    else if(quizManager.score >= 4 && quizManager.score < 7){
                        Text("C’est pas si mal 🙂")
                            .font(Font.custom("Nunito-Regular", size: 28))
                        Text("Ton score est de \(quizManager.score) sur \(quizManager.length)")
                    }
                    else{
                        Text("Ce n’est pas si grave 🤗")
                            .font(Font.custom("Nunito-Regular", size: 28))
                        Text("Ton score est de \(quizManager.score) sur \(quizManager.length)")
                    }
                    
                    
                    NavigationLink {
                         HomeView()
                    } label: {
                        PrimaryButton(text: "Revenir à l'écran d'accueil",
                                      foreground: quizManager.answerSelected ? Color.init(hex: "#FFFFFF")! : Color.init(hex:"#A8A29E") ?? Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 1.327),
                                      background: quizManager.answerSelected ? Color.init(hex: "#84C46C")! : Color.init(hex:"#E7E5E4") ?? Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 1.327))
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
