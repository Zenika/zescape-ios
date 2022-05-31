//
//  HomeView.swift
//  Zespace
//
//  Created by Anthony on 31/05/2022.
//

import SwiftUI

struct HomeView: View {
    @State private var selection: String? = nil
    private var titleGameColor: String = "Game Color"
    private var titleNFC: String = "NFC"
    private var titleQRCode: String = "QRCode"


    var body: some View {
        NavigationView {
            ZStack{
                HStack{
                    Group {
//                        PrimaryButton(title: "NFC")
//                        PrimaryButton(title: "QRCode")
                        
                        Button {
                            selection = titleNFC
                        } label: {
                            Text(titleNFC)
                                .font(.title)
                                .fontWeight(.heavy)
                                .padding()
                        }
                        .frame(minWidth: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue,lineWidth: 2)

                        )
                        
                        Button {
                            selection = titleQRCode
                        } label: {
                            Text(titleQRCode)
                                .font(.title)
                                .fontWeight(.heavy)
                                .padding()
                        }
                        .frame(minWidth: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue,lineWidth: 2)

                        )
            
                    } .padding()
                }
                .frame(width:480 , height: 600, alignment: .top)
               
                HStack{
                    Button {
                        selection = titleGameColor
                    } label: {
                        Text(titleGameColor)
                            .font(.title)
                            .fontWeight(.heavy)
                            .padding()
                    }
                    .frame(minWidth: 150)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue,lineWidth: 2)

                    )
                    
                }.frame(width:480 , height: 200, alignment: .center)
                
                
                NavigationLink(destination: GameColorView(rGuess: 0, gGuess: 0, bGuess: 0), tag: titleGameColor, selection: $selection) { EmptyView() }
                NavigationLink(destination: Text("View NFC"), tag: titleNFC, selection: $selection) { EmptyView() }
                NavigationLink(destination: Text("View QRCode"), tag: titleQRCode, selection: $selection) { EmptyView() }


                
            }
        }
        .navigationBarTitle("Z Escape")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct PrimaryButton: View {
    var title: String

    var body: some View {
        Button {
            
        } label: {
            Text(title)
                .font(.title)
                .fontWeight(.heavy)
                .padding()
        }
        .frame(minWidth: 150)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.blue,lineWidth: 2)
            
        )
    }
}

