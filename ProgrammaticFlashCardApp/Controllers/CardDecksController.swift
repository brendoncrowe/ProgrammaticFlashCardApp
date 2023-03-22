//
//  ViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

class CardDecksController: UIViewController {
    
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
        cardDeckView.tableView.delegate = self
        cardDeckView.tableView.dataSource = self
    }
    
    @objc private func addCardDeckButtonPressed(_ sender: UIBarButtonItem) {
        
    }
}


extension CardDecksController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardDeckView.tableView.dequeueReusableCell(withIdentifier: "deckCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "Hi There!"
        cell.contentConfiguration = content
        return cell
    }
}

extension CardDecksController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cardDeckView.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

