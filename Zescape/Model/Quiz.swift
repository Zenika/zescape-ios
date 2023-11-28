//
//  Quiz.swift
//  Zescape
//
//  Created by Anthony on 04/07/2022.
//

import Foundation

struct Quiz: Decodable {
    var results: [Result]
    
    struct Result: Decodable, Identifiable {
        var id: UUID {
            UUID()
        }
        var category: String
        var type: String
        var question: String
        var correctAnswer:String
        var incorrectAnswers: [String]
        
        var formattedQuestion: AttributedString{
            do {
                return try AttributedString(markdown: question)
            } catch {
                print("Error setting formattedQuestion: \(error)")
                return ""
            }
        }
        
        var answers: [Answer] {
            do {
                // Formatting all answer strings into AttributedStrings and creating an instance of Answer for each
                let correct = [Answer(text: try AttributedString(markdown: correctAnswer), isCorrect: true, isSelected: false)]
                let incorrects = try incorrectAnswers.map { answer in
                    Answer(text: try AttributedString(markdown: answer), isCorrect: false, isSelected: false)
                }
                
                // Merging the correct and incorrect arrays together
                let allAnswers = correct + incorrects
                
                // Shuffling the answers so the correct answer isn't always the first answer of the array
                return allAnswers.shuffled()
            } catch {
                // If we run into an error, return an empty array
                print("Error setting answers: \(error)")
                return []
            }
        }
    }
}
