//
//  CarModel.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import Foundation

typealias Writable = Codable & Equatable

struct CardDeck: Writable  {
    var title: String
    var description: String
    var flashCards: [FlashCard]
    
    static var dummyData = [CardDeck(title: "Test1 title", description: "Test1 Description", flashCards: []),
                        CardDeck(title: "Test2 title", description: "Test2 Description", flashCards: []),
                        CardDeck(title: "Test3 title", description: "Test3 Description", flashCards: [FlashCard(question: "What is Math", answer: "The study of numbers!"),
                            FlashCard(question: "What is Math", answer: "The study of numbers!"),
                            FlashCard(question: "What is Math", answer: "The study of numbers!") ])]
    
}

struct FlashCard: Writable {
    let question: String
    let answer: String
}
