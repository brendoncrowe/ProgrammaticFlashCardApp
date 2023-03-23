//
//  FlashCardCollectionViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

class FlashCardCollectionViewController: UIViewController {
    
    public var cardDeck: CardDeck?
    private var flashCards = [FlashCard]()
    private let flashCardView = FlashCardsView()
    
    private var barButton: UIBarButtonItem!
    
    override func loadView() {
        super.loadView()
        view = flashCardView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        barButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = barButton
    }
}
