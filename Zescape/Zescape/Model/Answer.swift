//
//  Answer.swift
//  Zescape
//
//  Created by Anthony on 04/07/2022.
//

import Foundation

struct Answer: Identifiable {
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
    
    
}
