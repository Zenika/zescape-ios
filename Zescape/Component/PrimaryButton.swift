//
//  PrimaryButton.swift
//  Zescape
//
//  Created by Anthony on 04/07/2022.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var foreground:Color = Color.init(hex: "#84C46C")!
    var background:Color = Color.init(hex: "#A8A29E")!
    
    var body: some View {
        Text(text)
            .foregroundColor(foreground)
            .padding()
            .padding(.horizontal)
            .background(background)
            .cornerRadius(30)
            .shadow(radius: 10)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(text: "Valider")
    }
}
