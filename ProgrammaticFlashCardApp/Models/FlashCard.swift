//
//  CarModel.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import Foundation

typealias Writable = Codable & Equatable

struct CardDeck: Writable {
    let title: String
    let description: String
    let flashCards: [FlashCard]?
    
    static var decks = [CardDeck(title: "Test1 title", description: "Test1 Description", flashCards: nil),
                        CardDeck(title: "Test2 title", description: "Test2 Description", flashCards: nil),
                        CardDeck(title: "Test3 title", description: "Test3 Description", flashCards: nil)]
    
}

struct FlashCard: Writable {
    let question: String
    let answer: String
}
