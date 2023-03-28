//
//  CreateCardDeckView.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import UIKit

class CreateCardDeckView: UIView {
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "create a new card deck"
        label.alpha = 0.6
        return label
    }()
    
    public lazy var deckTitleTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.preferredFont(forTextStyle: .body)
        tf.borderStyle = .roundedRect
        tf.placeholder = "enter deck title"
        return tf
    }()
    
    public lazy var deckDescriptionTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.preferredFont(forTextStyle: .body)
        tf.borderStyle = .roundedRect
        tf.placeholder = "enter deck description"
        return tf
    }()
    
    
    public lazy var createDeckButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create", for: .normal)
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
        setDeckTitleTextFieldConstraints()
        setDeckDescriptionTextFieldConstraints()
        setButtonLayoutConstraints()
    }
    
    private func setDeckTitleTextFieldConstraints() {
        addSubview(deckTitleTextField)
        NSLayoutConstraint.activate([
            deckTitleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            deckTitleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            deckTitleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            deckTitleTextField.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    
    private func setDeckDescriptionTextFieldConstraints() {
        addSubview(deckDescriptionTextField)
        NSLayoutConstraint.activate([
            deckDescriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            deckDescriptionTextField.topAnchor.constraint(equalTo: deckTitleTextField.bottomAnchor, constant: 16),
            deckDescriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            deckDescriptionTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setTitleLabelConstraints() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    
    private func setButtonLayoutConstraints() {
        addSubview(createDeckButton)
        NSLayoutConstraint.activate([
            createDeckButton.topAnchor.constraint(equalTo: deckDescriptionTextField.bottomAnchor, constant: 30),
            createDeckButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            createDeckButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 130),
            createDeckButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -130),
            createDeckButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
