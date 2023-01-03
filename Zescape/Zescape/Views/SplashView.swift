//
//  SplashScreen.swift
//  Zespace
//
//  Created by Anthony on 31/05/2022.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            
            if self.isActive {
                HomeView()
            } else {

                Image("Splashscreen")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
        .background(Color.black)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
