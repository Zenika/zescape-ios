//
//  FloatingMenu.swift
//  Zescape
//
//  Created by Anthony on 09/08/2022.
//

import SwiftUI

struct FloatingMenu: View {
    
    @State var showMenuItem1 = false
    @State var showMenuItem2 = false
    @State var showMenuItem3 = false
    
    var body: some View {
        VStack {
            Spacer()
            if showMenuItem1 {
                MenuItem(icon: "NFC")
            }
            if showMenuItem2 {
                MenuItem(icon: "QRCODE")
            }
           
            Button(action: {
                self.showMenu()
            }) {
                ZStack {
                    Circle()
                       .fill(.green)
                       .frame(width: 50, height: 50)
                    Image("FloatMenu")
                        .resizable()
                        .frame(width: 19, height: 19)
                        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                }
            }
        }
    }
    
    func showMenu() {
        withAnimation {
            self.showMenuItem3.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.showMenuItem2.toggle()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            withAnimation {
                self.showMenuItem1.toggle()
            }
        })
    }
}

struct FloatingMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingMenu()
    }
}

struct MenuItem: View {
    
    var icon: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.green)
                .frame(width: 55, height: 55)
            Image(icon)
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
        .transition(.move(edge: .trailing))
    }
}
