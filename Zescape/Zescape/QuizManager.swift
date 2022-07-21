//
//  QuizManager.swift
//  Zescape
//
//  Created by Anthony on 06/07/2022.
//

import Foundation
import SwiftUI

class QuizManager: ObservableObject {
    // Variables to set quiz and length of quiz
    private(set) var quiz: [Quiz.Result] = []
    @Published private(set) var length = 0
    
    // Variables to set question and answers
    @Published private(set) var index = 0
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    
    // Variables for score and progress
    @Published private(set) var score = 0
    @Published private(set) var progress: CGFloat = 0.00
    
    // Variables to know if an answer has been selected and reached the end of quiz
    @Published private(set) var answerSelected = false
    @Published private(set) var isValidated = false
    @Published private(set) var reachedEnd = false
    

    
    // Call the fetchQuiz function on intialize of the class, asynchronously
    init() {
        Task.init {
            await fetchMock()
        }
    }
    
    func fetchQuiz() async {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let decoder = JSONDecoder()
            // Line below allows us to convert the correct_answer key from the API into the correctAnswer in our Quiz model, without running into an error from the JSONDecoder that it couldn't find a matching codingKey
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Quiz.self, from: data)
            
            DispatchQueue.main.async {
                // Reset variables before assigning new values, for when the user plays the game another time
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false
                
                // Set new values for all variables
                self.quiz = decodedData.results
                self.length = self.quiz.count
                self.setQuestion()
            }
        } catch {
            print("Error fetching quiz: \(error)")
        }
        
        
    }
    
    func fetchMock() async {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json")
        else {
            print("Json file not found")
            return
        }
        do {
            let data = (try? Data(contentsOf: url))!
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Quiz.self, from: data)
            DispatchQueue.main.async {
                // Reset variables before assigning new values, for when the user plays the game another time
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false
                
                // Set new values for all variables
                self.quiz = decodedData.results
                self.length = self.quiz.count
                self.setQuestion()
            }
        }
        catch {
            print("Error fetching quiz: \(error)")
        }
    }
    
    // Function to go to next question. If reached end of the quiz, set reachedEnd to true
    func goToNextQuestion() {
        // If didn't reach end of array, increment index and set next question
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            // If reached end of array, set reachedEnd to true
            reachedEnd = true
        }
    }
    
    // Function to set a new question and answer choices, and update the progress
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double((index + 1)) / Double(length) * 350)
        
        // Only setting next question if index is smaller than the quiz's length
        if index < length {
            let currentQuizQuestion = quiz[index]
            question = currentQuizQuestion.formattedQuestion
            answerChoices = currentQuizQuestion.answers
        }
    }
    
    // Function to know that user selected an answer, and update the score
    func selectAnswer(answer: Answer) {
        answerSelected = true
        
        // If answer is correct, increment score
        if answer.isCorrect {
            score += 1
        }
    }
    
    // Function to know that user click on Validate button
    func setValidated(isVal: Bool) {
        isValidated = isVal
    }
}
