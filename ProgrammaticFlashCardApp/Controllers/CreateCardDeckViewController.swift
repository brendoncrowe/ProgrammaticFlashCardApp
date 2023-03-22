//
//  CreateCardDeckViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

class CreateCardDeckViewController: UIViewController {
    
    private var createCardDeckView = CreateCardDeckView()
    
    private var doneButton: UIBarButtonItem!

    
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
    }
    
    @objc private func createButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    private func createCardDeck() {
        // TODO: done button is inactive until title is given
        
        // TODO: text field for both the title and description that will come from the view model
        
        dismiss(animated: true)
    }
}


extension CreateCardDeckViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            
            return
        }
        
        print(text)
    }
    
}
