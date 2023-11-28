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
    
    @State var counter: Int = 0
    var countTo: Int = 60
    
    @StateObject var quizManager = QuizManagerVM()
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
                }.frame(width:400 , height: 700, alignment: .top)
                
                VStack {
                    CountdownTimer()
                    Text("🔥 Le temps est compté 🔥")
                        .font(Font.custom("Nunito-Regular", size: 16))
                        .padding(.bottom, 5.0)
                    
                    HStack {
                        Text("Vous avez X minutes pour trouver tous les indices qui vous permettront d’arriver au coffre ... Bon courage !")
                            .font(Font.custom("Nunito-Regular", size: 14))
                    }
                    .padding(.horizontal, 30.0)
                    
                }.frame(width:400 , height: 550, alignment: .top)
                
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    FloatingMenu()
                        .padding()
                }
                
                //Remove this code below line 61 to 95 when FloatingMenu works
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
                }.frame(width:400 , height: 200, alignment: .bottom)
                
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
                }.padding(10.0).frame(width:400 , height: 500, alignment: .bottom)
            }
            //end
            .toolbar {
                ToolbarItem(placement: .principal) { // <3>
                    VStack {
                        Image("Logo")
                        
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

