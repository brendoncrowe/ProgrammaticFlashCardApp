//
//  CreateCardDeckViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit


protocol CreateCardDeckViewControllerDelegate: NSObject {
    func didCreate(_ sender: CreateCardDeckViewController, cardDeck: CardDeck)
}

class CreateCardDeckViewController: UIViewController {
    
    private var createCardDeckView = CreateCardDeckView()
    public weak var delegate: CreateCardDeckViewControllerDelegate?
    private var createButtonIsActive = false
    private var cardDeck: CardDeck?
    
    init?(_ cardDeck: CardDeck?) {
        self.cardDeck = cardDeck
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = createCardDeckView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Add a Card Deck"
        createCardDeckView.createDeckButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        createCardDeckView.deckDescriptionTextField.delegate = self
        createCardDeckView.deckTitleTextField.delegate = self
        updateSaveButtonState()
        configureUI()
    }
    
    private func configureUI() {
        if cardDeck != nil {
            createCardDeckView.deckTitleTextField.text = cardDeck?.title
            createCardDeckView.deckDescriptionTextField.text = cardDeck?.description
            createCardDeckView.createDeckButton.setTitle("Update", for: .normal)
            createCardDeckView.titleLabel.text = "update current deck"
            updateSaveButtonState()
        }
    }

    
    private func performButtonShakeAnimation(_ button: UIButton) {
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1) {
                button.transform = CGAffineTransform(translationX: 20, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1) {
                button.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1) {
                button.transform = CGAffineTransform(translationX: -20, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.1) {
                button.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.1) {
                button.transform = CGAffineTransform(translationX: 20, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.1) {
                button.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.1) {
                button.transform = CGAffineTransform(translationX: -20, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.1) {
                button.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.1) {
                button.transform = CGAffineTransform(translationX: 20, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1) {
                button.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
        })
    }
    
    @objc private func createButtonTapped(_ sender: UIButton) {
        if createButtonIsActive == false {
            performButtonShakeAnimation(createCardDeckView.createDeckButton)
            
        } else {
            createCardDeck()
            dismiss(animated: true)
        }
    }
    
    private func updateSaveButtonState() {
        let deckTitle = createCardDeckView.deckTitleTextField.text ?? ""
        if !deckTitle.isEmpty {
            createButtonIsActive = true
        }
    }
    
    private func createCardDeck() {
        guard let deckTitle = createCardDeckView.deckTitleTextField.text,
              let deckDescription = createCardDeckView.deckDescriptionTextField.text else { return }
        let cardDeck = CardDeck(title: deckTitle, description: deckDescription, flashCards: [])
        delegate?.didCreate(self, cardDeck: cardDeck)
        dismiss(animated: true)
    }
}

extension CreateCardDeckViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            updateSaveButtonState()
            return
        }
        updateSaveButtonState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        createCardDeck()
        return true
    }
    
}


