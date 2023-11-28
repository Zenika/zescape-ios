//
//  QRCodeScannerResultView.swift
//  Zescape
//
//  Created by Anthony on 03/06/2022.
//

import SwiftUI

struct QRCodeScannerResultView: View {
    @State var result: String

    var body: some View {
        if(result.contains("https")){
            Link("Volcamp", destination: URL(string: result)!)
        }
        else{
            Text("Result = ") + Text(result)
        }
    }
}

struct QRCodeScannerResultView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerResultView(result: "My QRcode Result")
    }
}
