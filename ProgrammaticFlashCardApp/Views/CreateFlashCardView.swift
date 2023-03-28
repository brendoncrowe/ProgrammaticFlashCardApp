//
//  CreateFlashCardView.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

class CreateFlashCardView: UIView {
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "add a flash card"
        label.alpha = 0.6
        return label
    }()
    
    public lazy var cardQuestionTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .systemBackground
        tf.font = UIFont.preferredFont(forTextStyle: .body)
        tf.placeholder = "enter card title"
        return tf
    }()
    
    public lazy var cardAnswerTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.cornerRadius = 6
        tv.font = UIFont.preferredFont(forTextStyle: .body)
        tv.layer.borderColor = UIColor.systemGray3.cgColor
        tv.layer.borderWidth = 0.4
        return tv
    }()
    
    public lazy var createCardButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Card", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 24
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setTitleLabelConstraints()
        setCardQuestionTextFieldConstraints()
        setCardAnswerTextViewConstraints()
        setButtonLayoutConstraints()
    }
    
    private func setTitleLabelConstraints() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    
    private func setCardQuestionTextFieldConstraints() {
        addSubview(cardQuestionTextField)
        NSLayoutConstraint.activate([
            cardQuestionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            cardQuestionTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            cardQuestionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        
        ])
    }
    
    private func setCardAnswerTextViewConstraints() {
        addSubview(cardAnswerTextView)
        NSLayoutConstraint.activate([
            cardAnswerTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            cardAnswerTextView.topAnchor.constraint(equalTo: cardQuestionTextField.bottomAnchor, constant: 16),
            cardAnswerTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            cardAnswerTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setButtonLayoutConstraints() {
        addSubview(createCardButton)
        NSLayoutConstraint.activate([
            createCardButton.topAnchor.constraint(equalTo: cardAnswerTextView.bottomAnchor, constant: 20),
            createCardButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            createCardButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120),
            createCardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -120),
            createCardButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
