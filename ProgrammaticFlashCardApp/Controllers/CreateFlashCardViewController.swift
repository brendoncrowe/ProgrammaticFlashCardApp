//
//  CreatFlashCardViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

protocol CreateFlashCardViewControllerDelegate: NSObject {
    func didCreate(_ sender: CreateFlashCardViewController, flashCard: FlashCard)
}

class CreateFlashCardViewController: UIViewController {
    
    private var createCardView = CreateFlashCardView()
    public weak var delegate: CreateFlashCardViewControllerDelegate?
    private var flashCard: FlashCard?

    override func loadView() {
        super.loadView()
        view = createCardView
    }
    
    init?(flashCard: FlashCard?) {
        self.flashCard = flashCard
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        updateSaveButtonState()
        createCardView.createCardButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        createCardView.cardQuestionTextField.delegate = self
        configureUI()
    }
    
    private func configureUI() {
        if flashCard != nil {
            createCardView.cardQuestionTextField.text = flashCard?.question
            createCardView.cardAnswerTextView.text = flashCard?.answer
            updateSaveButtonState()
        }
    }
    
    
    @objc private func createButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
        createFlashCard()
    }
    

    private func updateSaveButtonState() {
        let cardQuestion = createCardView.cardQuestionTextField.text ?? ""
        createCardView.createCardButton.isEnabled =  !cardQuestion.isEmpty
    }
    
    private func createFlashCard() {
        guard let cardQuestion = createCardView.cardQuestionTextField.text,
              let cardAnswer = createCardView.cardAnswerTextView.text else { return }
        let flashCard = FlashCard(question: cardQuestion, answer: cardAnswer)
        delegate?.didCreate(self, flashCard: flashCard)
        dismiss(animated: true)
    }
}

extension CreateFlashCardViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            updateSaveButtonState()
            return
        }
        updateSaveButtonState()
    }
}

