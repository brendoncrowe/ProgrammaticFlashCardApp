//
//  ViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

class CardDecksTableViewController: UIViewController {
    
    private let cardDeckView = CardDeckTableView()
    private var currentCardDeck: CardDeck?
    private var cardDecks = [CardDeck]() {
        didSet {
            cardDeckView.tableView.reloadData()
        }
    }
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
        addCardDeckButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addCardDeckButtonPressed))
        navigationItem.rightBarButtonItem = addCardDeckButton
        cardDeckView.tableView.dataSource = self
        cardDeckView.tableView.delegate = self
        cardDecks = CardDeck.decks
    }
    
    @objc private func addCardDeckButtonPressed(_ sender: UIBarButtonItem) {
        presentViewController()
    }
    
    private func presentViewController() {
        let viewController = CreateCardDeckViewController()
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [ .medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
            sheet.largestUndimmedDetentIdentifier = .large
        }
        viewController.delegate = self
        present(viewController, animated: true)
    }
}

extension CardDecksTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardDecks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deckCell", for: indexPath)
        let cardDeck = cardDecks[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        var content = cell.defaultContentConfiguration()
        content.text = cardDeck.title
        content.secondaryText = cardDeck.description
        cell.contentConfiguration = content
        return cell
    }
}

extension CardDecksTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cardDeck = cardDecks[indexPath.row]
        currentCardDeck = cardDeck
        let flashCardVC = FlashCardCollectionViewController(cardDeck: cardDeck)
        flashCardVC.delegate = self
        flashCardVC.cardDeck = cardDecks[indexPath.row]
        navigationController?.pushViewController(flashCardVC, animated: true)
    }
}

extension CardDecksTableViewController: CreateCardDeckViewControllerDelegate {
    func didCreate(_ sender: CreateCardDeckViewController, cardDeck: CardDeck) {
        cardDecks.append(cardDeck)
    }
}

extension CardDecksTableViewController: FlashCardCollectionViewControllerDelegate {
    func flashCardWasAdded(_ sender: FlashCardCollectionViewController, toCardDeck: CardDeck) {
        guard let index = cardDecks.firstIndex(of: currentCardDeck!) else { return }
        print("called")
        cardDecks[index] = toCardDeck
    }
}



