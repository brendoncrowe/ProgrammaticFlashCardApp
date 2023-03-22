//
//  CreateCardDeckViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

class CreateCardDeckViewController: UIViewController {
    
    private var doneButton: UIBarButtonItem!
    private var addButtonIsActive = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        navigationItem.title = "Add a Card Deck"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView(_:)))
        
    }
    
    @objc private func dismissView(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    private func createCardDeck() {
        
    }
}
