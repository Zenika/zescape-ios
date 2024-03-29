//
//  NFCUtility.swift
//  Zescape
//
//  Created by Anthony on 03/06/2022.
//

import Foundation
import CoreNFC

typealias NFCReadingCompletion = (Result<NFCNDEFMessage?, Error>) -> Void
typealias LocationReadingCompletion = (Result<NFCModel, Error>) -> Void

enum NFCError: LocalizedError {
  case unavailable
  case invalidated(message: String)
  case invalidPayloadSize

  var errorDescription: String? {
    switch self {
    case .unavailable:
      return "NFC Reader Not Available"
    case let .invalidated(message):
      return message
    case .invalidPayloadSize:
      return "NDEF payload size exceeds the tag limit"
    }
  }
}

class NFCUtility: NSObject {
  enum NFCAction {
    case readLocation
    case setupNFC(locationName: String)
    case addVisitor(visitorName: String)

    var alertMessage: String {
      switch self {
      case .readLocation:
        return "Place tag near iPhone to read the location."
      case .setupNFC(let locationName):
        return "Place tag near iPhone to setup \(locationName)"
      case .addVisitor(let visitorName):
        return "Place tag near iPhone to add \(visitorName)"
      }
    }
  }

  private static let shared = NFCUtility()
  private var action: NFCAction = .readLocation

  // 1
  private var session: NFCNDEFReaderSession?
  private var completion: LocationReadingCompletion?

  // 2
  static func performAction(
    _ action: NFCAction,
    completion: LocationReadingCompletion? = nil
  ) {
    // 3
    guard NFCNDEFReaderSession.readingAvailable else {
      completion?(.failure(NFCError.unavailable))
      print("NFC is not available on this device")
      return
    }

    shared.action = action
    shared.completion = completion
    // 4
    shared.session = NFCNDEFReaderSession(
      delegate: shared.self,
      queue: nil,
      invalidateAfterFirstRead: false)
    // 5
    shared.session?.alertMessage = action.alertMessage
    // 6
    shared.session?.begin()
  }
}

// MARK: - NFC NDEF Reader Session Delegate
extension NFCUtility: NFCNDEFReaderSessionDelegate {
  func readerSession(
    _ session: NFCNDEFReaderSession,
    didDetectNDEFs messages: [NFCNDEFMessage]
  ) {
    // Not used
  }

  private func handleError(_ error: Error) {
    session?.alertMessage = error.localizedDescription
    session?.invalidate()
  }

  func readerSession(
    _ session: NFCNDEFReaderSession,
    didInvalidateWithError error: Error
  ) {
    if
      let error = error as? NFCReaderError,
      error.code != .readerSessionInvalidationErrorFirstNDEFTagRead &&
        error.code != .readerSessionInvalidationErrorUserCanceled {
      completion?(.failure(NFCError.invalidated(message: error.localizedDescription)))
    }

    self.session = nil
    completion = nil
  }

  func readerSession(
    _ session: NFCNDEFReaderSession,
    didDetect tags: [NFCNDEFTag]
  ) {
    guard
      let tag = tags.first,
      tags.count == 1
      else {
        session.alertMessage = "There are too many tags present. Remove all and then try again."
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(500)) {
          session.restartPolling()
        }
        return
    }

    // 1
    session.connect(to: tag) { error in
      if let error = error {
        self.handleError(error)
        return
      }

      // 2
      tag.queryNDEFStatus { status, _, error in
        if let error = error {
          self.handleError(error)
          return
        }

        // 3
        switch (status, self.action) {
        case (.notSupported, _):
          session.alertMessage = "Unsupported tag."
          session.invalidate()
        case (.readOnly, _):
          session.alertMessage = "Unable to write to tag."
          session.invalidate()
        case (.readWrite, .setupNFC(let nfcName)):
          self.createNFC(NFCModel(name: nfcName), tag: tag)
        case (.readWrite, .readLocation):
          self.read(tag: tag)
        default:
          return
        }
      }
    }
  }
}

// MARK: - Utilities
extension NFCUtility {
  func readLocation(from tag: NFCNDEFTag) {
    // 1
    tag.readNDEF { message, error in
      if let error = error {
        self.handleError(error)
        return
      }
      // 2
      guard
        let message = message,
        let location = NFCModel(message: message)
        else {
          self.session?.alertMessage = "Could not read tag data."
          self.session?.invalidate()
          return
      }
      self.completion?(.success(location))
      self.session?.alertMessage = "Read tag."
      self.session?.invalidate()
    }
  }

  private func read(
    tag: NFCNDEFTag,
    alertMessage: String = "Tag Read",
    readCompletion: NFCReadingCompletion? = nil
  ) {
    tag.readNDEF { message, error in
      if let error = error {
        self.handleError(error)
        return
      }

      // 1
      if let readCompletion = readCompletion,
        let message = message {
        readCompletion(.success(message))
      } else if let message = message,
        let record = message.records.first,
        let location = try? JSONDecoder()
          .decode(NFCModel.self, from: record.payload) {
        // 2
        self.completion?(.success(location))
        self.session?.alertMessage = alertMessage
        self.session?.invalidate()
      } else {
        self.session?.alertMessage = "Could not decode tag data."
        self.session?.invalidate()
      }
    }
  }

  private func createNFC(_ location: NFCModel, tag: NFCNDEFTag) {
    read(tag: tag) { _ in
      //self.updateLocation(location, tag: tag)
    }
  }

//  private func updateLocation(
//    _ location: NFCModel,
//    withVisitor visitor: Visitor? = nil,
//    tag: NFCNDEFTag
//  ) {
//    // 1
//    var alertMessage = "Successfully setup location."
//    var tempLocation = location
//
//    if let visitor = visitor {
//      tempLocation.visitors.append(visitor)
//      alertMessage = "Successfully added visitor."
//    }
//
//    // 2
//    let jsonEncoder = JSONEncoder()
//    guard let customData = try? jsonEncoder.encode(tempLocation) else {
//      self.handleError(NFCError.invalidated(message: "Bad data"))
//      return
//    }
//
//    // 3
//    let payload = NFCNDEFPayload(
//      format: .unknown,
//      type: Data(),
//      identifier: Data(),
//      payload: customData)
//    // 4
//    let message = NFCNDEFMessage(records: [payload])
//
//    tag.queryNDEFStatus { _, capacity, _ in
//      // 1
//      guard message.length <= capacity else {
//        self.handleError(NFCError.invalidPayloadSize)
//        return
//      }
//
//      // 2
//      tag.writeNDEF(message) { error in
//        if let error = error {
//          self.handleError(error)
//          return
//        }
//        if self.completion != nil {
//          self.read(tag: tag, alertMessage: alertMessage)
//        }
//      }
//    }
//  }
}
