//
//  ViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

class CardDecksTableViewController: UIViewController {
    
    private let cardDeckView = CardDeckTableView()
    private var cardDecks = [CardDeck]()
    private var addCardDeckButton: UIBarButtonItem!
    
    override func loadView() {
        super.loadView()
        view = cardDeckView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Card Decks"
        navigationController?.navigationBar.prefersLargeTitles = true
        addCardDeckButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addCardDeckButtonPressed))
        navigationItem.rightBarButtonItem = addCardDeckButton
        cardDeckView.tableView.dataSource = cardDeckView
        cardDeckView.tableView.delegate = self
    }
    
    @objc private func addCardDeckButtonPressed(_ sender: UIBarButtonItem) {
        createCardDeck()
    }
    
    private func createCardDeck() {
        let viewController = CreateCardDeckViewController()
        present(UINavigationController(rootViewController: viewController), animated: true)
    }
}


