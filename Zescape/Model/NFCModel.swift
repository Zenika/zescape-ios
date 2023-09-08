//
//  TagModel.swift
//  Zescape
//
//  Created by Anthony on 03/06/2022.
//

import CoreNFC

struct NFCModel: Codable {
   let name: String

  init(name: String) {
    self.name = name
  }

  init?(message: NFCNDEFMessage) {
    guard
      let nfcRecord = message.records.first,
      let nfcName = nfcRecord.wellKnownTypeTextPayload().0
      else {
        return nil
    }

      name = nfcName
  }
}
