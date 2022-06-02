//
//  QrCodeScannerView.swift
//  Zespace
//
//  Created by Anthony on 01/06/2022.
//

import SwiftUI
import CodeScanner

struct QRCodeScannerView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    @State private var isActive = false

    var body: some View {
        VStack(spacing: 10) {
            if let code = scannedCode {
                NavigationLink("Next page", destination: Text(code), isActive: .constant(isActive)).hidden()
            }

            Button("Scan Code") {
                isActive = false
                isPresentingScanner = true
            }

            Text("Scan a QR code to begin")
        }
        .sheet(isPresented: $isPresentingScanner) {
            
            CodeScannerView(codeTypes: [.qr]) { response in
                if case let .success(result) = response {
                    scannedCode = result.string
                    isPresentingScanner = false
                    isActive = true
                }
                else {
                    print("ERROR SCAN")
                }
            }
        }
    }
}

struct QrCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerView()
    }
}
