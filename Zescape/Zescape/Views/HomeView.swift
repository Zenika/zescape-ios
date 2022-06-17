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
    private var titleGameTwo: String = "Game 2"
    private var titleGameThree: String = "Game 3"
    
    var body: some View {
        
        let titles = [titleNFC, titleQRCode]
        let games = [titleGameColor, titleGameTwo, titleGameThree]
        
        
        NavigationView {
            ZStack {
                // The frame modifier allows the view to expand horizontally
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
                        else{
                            NavigationLink(destination: Text(item)) {
                                customTextStyle(title: item)
                            }
                        }
                    }
                }.padding(10.0).frame(width:400 , height: 300, alignment: .center)
                
                
            }
            .padding(.horizontal, 0.0)
            .navigationTitle("Z Escape")
        }.navigationViewStyle(StackNavigationViewStyle())
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

