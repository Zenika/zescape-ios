//
//  ScanView.swift
//  Zescape
//
//  Created by Anthony on 10/06/2022.
//

import SwiftUI

struct ScanView: View {
    
    @State private var nfcModel: NFCModel?

    var body: some View {
          
            Button(action: {
              NFCUtility.performAction(.readLocation) { location in
                self.nfcModel = try? location.get()
              }
            }) {
            
                Text(nfcModel?.name ?? "Scan NFC Tag")
            }
        
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
