//
//  FlashCardCollectionViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

protocol FlashCardCollectionViewControllerDelegate: NSObject {
    func flashCardWasAdded(_ sender: FlashCardCollectionViewController, toCardDeck: CardDeck)
}

class FlashCardCollectionViewController: UIViewController {
    
    public var cardDeck: CardDeck {
        didSet {
            flashCardView.collectionView.reloadData()
        }
    }
    public weak var delegate: FlashCardCollectionViewControllerDelegate?
    private let flashCardView = FlashCardsCollectionView()    
    private var barButton: UIBarButtonItem!
    
    override func loadView() {
        super.loadView()
        flashCardView.collectionView.dataSource = self
        flashCardView.collectionView.delegate = self
        view = flashCardView
    }
    
    init(cardDeck: CardDeck) {
        self.cardDeck = cardDeck
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = cardDeck.title
        barButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addCardButtonPressed))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc private func addCardButtonPressed(_ sender: UIBarButtonItem) {
        presentViewController()
    }
    
    private func presentViewController() {
        let viewController = CreateFlashCardViewController()
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
extension FlashCardCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardDeck.flashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = flashCardView.collectionView.dequeueReusableCell(withReuseIdentifier: "flashCardCell", for: indexPath)
        cell.backgroundColor = .systemCyan
        return cell
    }
    
    
}

extension FlashCardCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    
}

extension FlashCardCollectionViewController: CreateFlashCardViewControllerDelegate {
    
    func didCreate(_ sender: CreateFlashCardViewController, flashCard: FlashCard) {
        cardDeck.flashCards.append(flashCard)
        self.delegate?.flashCardWasAdded(self, toCardDeck: cardDeck)
    }
}
