//
//  ViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

class CardDecksTableViewController: UIViewController {
    
    private let cardDeckView = CardDeckTableView()
    private var dataPersistence = DataPersistence<CardDeck>(filename: "cardDecks.plist")
    private var currentCardDeck: CardDeck?
    private var cardDecks = [CardDeck]() {
        didSet {
            if cardDecks.isEmpty {
                // setup empty view
                cardDeckView.tableView.backgroundView = EmptyView()
            } else {
                // remove empty view
                cardDeckView.tableView.backgroundView = nil
            }
            cardDeckView.tableView.reloadData()
        }
    }
    private var addCardDeckButton: UIBarButtonItem!
    private var settingsButton: UIBarButtonItem!
    
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
        addCardDeckButton.tag = 0
        settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonPressed(_:)))
        settingsButton.tag = 1
        navigationItem.leftBarButtonItem = addCardDeckButton
        navigationItem.rightBarButtonItem = settingsButton
        cardDeckView.tableView.dataSource = self
        cardDeckView.tableView.delegate = self
    }
    
    @objc private func settingsButtonPressed(_ sender: UIBarButtonItem) {
        presentViewController(for: sender)
    }
    
    @objc private func addCardDeckButtonPressed(_ sender: UIBarButtonItem) {
        presentViewController(for: sender)
    }
    
    private func presentViewController(for sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            let viewController = CreateCardDeckViewController()
            if let sheet = viewController.sheetPresentationController {
                sheet.detents = [ .medium()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
                sheet.largestUndimmedDetentIdentifier = .large
            }
            viewController.delegate = self
            present(viewController, animated: true)
        case 1:
            let viewController = SettingsViewController()
            if let sheet = viewController.sheetPresentationController {
                sheet.detents = [ .medium()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
                sheet.largestUndimmedDetentIdentifier = .large
            }
            present(viewController, animated: true)
        default:
            return
        }
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
        let flashCardVC = FlashCardCollectionViewController(dataPersistence: dataPersistence, cardDeck: cardDeck)
        flashCardVC.delegate = self
        flashCardVC.cardDeck = cardDecks[indexPath.row]
        navigationController?.pushViewController(flashCardVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.performBatchUpdates {
            if editingStyle == .delete {
                tableView.deleteRows(at: [indexPath], with: .automatic)
                cardDecks.remove(at: indexPath.row)
            }
        }
    }
}

extension CardDecksTableViewController: CreateCardDeckViewControllerDelegate {
    func didCreate(_ sender: CreateCardDeckViewController, cardDeck: CardDeck) {
        cardDecks.append(cardDeck)
    }
}

extension CardDecksTableViewController: FlashCardCollectionViewControllerDelegate {
    func flashCardWasAdded(_ sender: FlashCardCollectionViewController, cardDeck: CardDeck) {
        guard let index = cardDecks.firstIndex(of: currentCardDeck!) else { return }
        cardDecks[index] = cardDeck
    }
}
