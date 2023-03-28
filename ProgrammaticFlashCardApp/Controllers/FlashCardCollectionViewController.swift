//
//  FlashCardCollectionViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

protocol FlashCardCollectionViewControllerDelegate: NSObject {
    func flashCardWasAdded(_ sender: FlashCardCollectionViewController, cardDeck: CardDeck, indexPathRow: Int)
    func flashCardWasDeleted(_ sender: FlashCardCollectionViewController, cardDeck: CardDeck, indexPathRow: Int)
}

class FlashCardCollectionViewController: UIViewController {
    
    public var cardDeck: CardDeck {
        didSet {
            if cardDeck.flashCards.isEmpty {
                // setup empty view
                flashCardView.collectionView.backgroundView = EmptyView()
            } else {
                // remove empty view
                flashCardView.collectionView.backgroundView = nil
            }
            self.navigationItem.title = "\(cardDeck.title) (\(cardDeck.flashCards.count))"
        }
    }
    public var dataPersistence: DataPersistence<CardDeck>
    public weak var delegate: FlashCardCollectionViewControllerDelegate?
    private let flashCardView = FlashCardsCollectionView()
    private var barButton: UIBarButtonItem!
    private var cellColor: Int!
    public var indexPath: Int!
    
    override func loadView() {
        super.loadView()
        flashCardView.collectionView.dataSource = self
        flashCardView.collectionView.delegate = self
        view = flashCardView
    }
    
    init(dataPersistence: DataPersistence<CardDeck>, cardDeck: CardDeck) {
        self.cardDeck = cardDeck
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "\(cardDeck.title) (\(cardDeck.flashCards.count))"
        barButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addCardButtonPressed))
        navigationItem.rightBarButtonItem = barButton
        cellColor = UserDefaults.standard.object(forKey: UserPreferences.index) as? Int ?? 0
        
    }
    
    @objc private func addCardButtonPressed(_ sender: UIBarButtonItem) {
        presentViewController(nil)
    }
    
    private func presentViewController(_ card: FlashCard?) {
        if let card = card {
            let viewController = CreateFlashCardViewController(flashCard: card)
            if let sheet = viewController?.sheetPresentationController {
                sheet.detents = [ .medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
                sheet.largestUndimmedDetentIdentifier = .large
            }
            viewController?.delegate = self
            present(viewController!, animated: true)
        } else {
            let viewController = CreateFlashCardViewController(flashCard: nil)
            if let sheet = viewController?.sheetPresentationController {
                sheet.detents = [ .medium()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
                sheet.largestUndimmedDetentIdentifier = .large
            }
            viewController?.delegate = self
            present(viewController!, animated: true)
        }
    }
    
    private func configureCellColor(_ index: Int) -> UIColor? {
        switch index {
        case 0:
            return UIColor.systemBlue.withAlphaComponent(0.6)
        case 1:
            return UIColor.systemGreen.withAlphaComponent(0.6)
        case 2:
            return UIColor.systemYellow.withAlphaComponent(0.6)
        case 3:
            return UIColor.systemRed.withAlphaComponent(0.6)
        default:
            return UIColor.systemBlue.withAlphaComponent(0.6)
        }
    }
}

extension FlashCardCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardDeck.flashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = flashCardView.collectionView.dequeueReusableCell(withReuseIdentifier: "flashCardCell", for: indexPath) as? FlashCardCell else {
            fatalError("could not dequeue a FlashCardCell")
        }
        let flashcard = cardDeck.flashCards[indexPath.row]
        cell.layer.cornerRadius = 16
        cell.delegate = self
        cell.configureCell(for: flashcard)
        cell.backgroundColor = configureCellColor(cellColor)
        return cell
    }
}

extension FlashCardCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let flashCard = collectionView.cellForItem(at: indexPath) as? FlashCardCell else {
            return
        }
        if flashCard.flashCardAnswerLabel.isHidden == true {
            UIView.transition(with: collectionView.cellForItem(at: indexPath)!, duration: 0.4, options: [.transitionFlipFromRight, .curveEaseInOut]) {
                flashCard.flashCardAnswerLabel.isHidden = false
                flashCard.moreButton.isHidden = false
                flashCard.moreButton.isEnabled = true
                flashCard.flashCardQuestionLabel.isHidden = true
            }
        } else {
            UIView.transition(with: collectionView.cellForItem(at: indexPath)!, duration: 0.4, options: [.transitionFlipFromLeft, .curveEaseInOut]) {
                flashCard.flashCardQuestionLabel.isHidden = false
                flashCard.moreButton.isHidden = true
                flashCard.moreButton.isEnabled = false
                flashCard.flashCardAnswerLabel.isHidden = true
            }
        }
    }
}

extension FlashCardCollectionViewController: CreateFlashCardViewControllerDelegate {
    func didCreate(_ sender: CreateFlashCardViewController, flashCard: FlashCard) {
        let indexPath = IndexPath(row: 0, section: 0)
        cardDeck.flashCards.insert(flashCard, at: 0)
        flashCardView.collectionView.insertItems(at: [indexPath])
        flashCardView.collectionView.reloadData()
        self.delegate?.flashCardWasAdded(self, cardDeck: cardDeck, indexPathRow: self.indexPath)
    }
    
    func didUpdate(_ sender: CreateFlashCardViewController, oldFlashCard: FlashCard, newFlashCard: FlashCard) {
        if let card = cardDeck.flashCards.firstIndex(of: oldFlashCard) {
            cardDeck.flashCards[card] = newFlashCard
            flashCardView.collectionView.reloadData()
            self.delegate?.flashCardWasAdded(self, cardDeck: cardDeck, indexPathRow: indexPath)
        }
    }
}

extension FlashCardCollectionViewController: FlashCardCellDelegate {
    
    func didSelectMoreButton(_ savedFlashCardCell: FlashCardCell, card: FlashCard) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        let editAction = UIAlertAction(title: "edit", style: .default) { [weak self] _ in
            self?.presentViewController(card)
        }
        let deleteAction = UIAlertAction(title: "delete", style: .destructive) { [weak self] _ in
            self?.deleteFlashCard(card)
        }
        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func deleteFlashCard(_ card: FlashCard) {
        guard let index = cardDeck.flashCards.firstIndex(of: card) else { return }
        cardDeck.flashCards.remove(at: index)
        flashCardView.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        flashCardView.collectionView.reloadData()
        delegate?.flashCardWasDeleted(self, cardDeck: cardDeck, indexPathRow: indexPath)
        
    }
    
}
