//
//  PrimaryButton.swift
//  Zescape
//
//  Created by Anthony on 04/07/2022.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var background: Color = Color(.blue)
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
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
