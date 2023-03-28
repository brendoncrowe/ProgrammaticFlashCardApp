//
//  CreatFlashCardViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

protocol CreateFlashCardViewControllerDelegate: NSObject {
    func didCreate(_ sender: CreateFlashCardViewController, flashCard: FlashCard)
    func didUpdate(_ sender: CreateFlashCardViewController, oldFlashCard: FlashCard, newFlashCard: FlashCard)
}

class CreateFlashCardViewController: UIViewController {
    
    private var createCardView = CreateFlashCardView()
    public weak var delegate: CreateFlashCardViewControllerDelegate?
    private var flashCard: FlashCard?
    private var createButtonIsActive = false
    
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
            createCardView.createCardButton.setTitle("Update", for: .normal)
            createCardView.titleLabel.text = "update current card"
            updateSaveButtonState()
        }
    }
    
    @objc private func createButtonTapped(_ sender: UIButton) {
        if flashCard != nil {
            updateFlashCard()
            dismiss(animated: true)
        } else {
            createFlashCard()
        }
    }
    
    private func updateSaveButtonState() {
        let cardQuestion = createCardView.cardQuestionTextField.text ?? ""
        if !cardQuestion.isEmpty {
            createButtonIsActive = true
        }
    }
    
    private func updateFlashCard() {
        guard let cardQuestion = createCardView.cardQuestionTextField.text,
              let cardAnswer = createCardView.cardAnswerTextView.text else { return }
        let flashCard = FlashCard(question: cardQuestion, answer: cardAnswer)
        delegate?.didUpdate(self, oldFlashCard: self.flashCard!, newFlashCard: flashCard)
        dismiss(animated: true)
    }
    
    private func createFlashCard() {
        guard let cardQuestion = createCardView.cardQuestionTextField.text, !cardQuestion.isEmpty,
              let cardAnswer = createCardView.cardAnswerTextView.text else {
            performButtonShakeAnimation(createCardView.createCardButton)
            return
            
        }
        let flashCard = FlashCard(question: cardQuestion, answer: cardAnswer)
        delegate?.didCreate(self, flashCard: flashCard)
        dismiss(animated: true)
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

