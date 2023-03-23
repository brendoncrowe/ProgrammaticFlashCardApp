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
    
    static var dummyData = [CardDeck(title: "Math", description: "Math related questions", flashCards: []),
                        CardDeck(title: "Sports Teams", description: "Trying to learn ncaa football teams", flashCards: []),
                        CardDeck(title: "Planets", description: "keep forgetting them", flashCards: [FlashCard(question: "Earth", answer: "The place where humans live"),
                            FlashCard(question: "Pluto", answer: "Who cares about it?!"),
                            FlashCard(question: "Mars", answer: "The place we hope to live. Go get it Elon!") ])]
    
}

struct FlashCard: Writable {
    let question: String
    let answer: String
}
