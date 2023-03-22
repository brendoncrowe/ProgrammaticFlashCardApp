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
}

struct FlashCard: Writable {
    let question: String
    let answer: String
}
