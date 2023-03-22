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
    private var addButtonIsActive = false
    
    override func loadView() {
        super.loadView()
        view = createCardDeckView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Add a Card Deck"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView(_:)))
        
    }
    
    @objc private func dismissView(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    private func createCardDeck() {
        // TODO: done button is inactive until title is given
        
        // TODO: text field for both the title and description that will come from the view model
        
        dismiss(animated: true)
    }
}
