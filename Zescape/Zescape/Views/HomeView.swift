//
//  HomeView.swift
//  Zespace
//
//  Created by Anthony on 31/05/2022.
//

import SwiftUI

struct HomeView: View {
    
    private var titleNFC: String = "NFC"
    private var titleQRCode: String = "QRCode"
    
    private var titleGameColor: String = "Game Color"
    private var titleQuizGame: String = "Quiz Game"
    private var titleGameThree: String = "Game 3"
    
    @StateObject var quizManager = QuizManager()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        let titles = [titleNFC, titleQRCode]
        let games = [titleGameColor, titleQuizGame, titleGameThree]
        
        NavigationView {
            ZStack {
                // The frame modifier allows the view to expand horizontally
                VStack{
                    Text("NOM DU Z GAME")
                        .foregroundColor(colorScheme == .dark ?Color.white:Color.black)
                        .font(Font.custom("Nunito-Regular", size: 36))
                    
                    Text(" Volcamp is on 🔥 Retrouve les Hot Z et allume toi aussi le feu  🔥 🔥")
                        .foregroundColor(Color.init(hex: "#A3A3A3"))
                        .font(Font.custom("Nunito-Regular", size: 16))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 50.0)

                    
                }.frame(width:400 , height: 700, alignment: .top)
              
                HStack {
                    ForEach(titles, id: \.self) { item in
                        if(item == titleNFC){
                            NavigationLink(destination: ScanView()) {
                                customTextStyle(title: item)
                            }
                        }
                        else {
                            
                            NavigationLink(destination: QRCodeScannerView()) {
                                customTextStyle(title: item)
                            }
                        }
                    }
                    .padding(10.0)
                }.frame(width:400 , height: 500, alignment: .top)
                
                VStack {
                    ForEach(games, id: \.self) { item in
                        if(item == titleGameColor){
                            NavigationLink(destination: GameColorView(rGuess: 0, gGuess: 0, bGuess: 0)) {
                                customTextStyle(title: item)
                            }
                        }
                        else if(item == titleQuizGame){
                            NavigationLink(destination: QuizView().environmentObject(quizManager))
                            {
                                customTextStyle(title: item)
                                
                            }
                            
                        }
                    }
                }.padding(10.0).frame(width:400 , height: 300, alignment: .center)
            }
            .toolbar {
                ToolbarItem(placement: .principal) { // <3>
                    VStack {
                        Image("Logo")
                            .aspectRatio(contentMode: .fit)
                            .padding(.top)
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct customTextStyle: View {
    var title: String
    
    var body: some View {
        Text(title)
            .fontWeight(.heavy)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue,lineWidth: 2))
            .font(.title)
    }
}

