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
        loadDecks()
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
    
    private func loadDecks() {
        cardDecks = try! dataPersistence.loadItems()
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
        let flashCardVC = FlashCardCollectionViewController(dataPersistence: dataPersistence, cardDeck: cardDeck)
        flashCardVC.delegate = self
        flashCardVC.indexPath = indexPath.row
        flashCardVC.cardDeck = cardDeck
        navigationController?.pushViewController(flashCardVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.performBatchUpdates {
            if editingStyle == .delete {
                tableView.deleteRows(at: [indexPath], with: .automatic)
                cardDecks.remove(at: indexPath.row)
                do {
                    try dataPersistence.deleteItem(at: indexPath.row)
                } catch {
                    print("Error deleting: \(error)")
                }
            }
        }
    }
}

extension CardDecksTableViewController: CreateCardDeckViewControllerDelegate {
    func didCreate(_ sender: CreateCardDeckViewController, cardDeck: CardDeck) {
        cardDecks.append(cardDeck)
        do {
            try dataPersistence.createItem(cardDeck)
        } catch {
            print("Error saving: \(error)")
        }
    }
}

extension CardDecksTableViewController: FlashCardCollectionViewControllerDelegate {
    func flashCardWasAdded(_ sender: FlashCardCollectionViewController, cardDeck: CardDeck, indexPathRow: Int) {
        // set old card deck to new card deck
        let oldCardDeck = cardDecks[indexPathRow]
        dataPersistence.update(oldCardDeck, with: cardDeck)
        loadDecks()
    }
    
    func flashCardWasDeleted(_ sender: FlashCardCollectionViewController, cardDeck: CardDeck, indexPathRow: Int) {
        let oldCardDeck = cardDecks[indexPathRow]
        dataPersistence.update(oldCardDeck, with: cardDeck)
        loadDecks()
    }
}
