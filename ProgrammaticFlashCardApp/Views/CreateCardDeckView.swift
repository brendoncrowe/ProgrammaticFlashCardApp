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
        label.text = "Create a new card deck"
        label.alpha = 0.6
        return label
    }()
    
    public lazy var deckTitleTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "enter deck title"
        return tf
    }()
    
    public lazy var deckDescriptionTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "enter deck description"
        return tf
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
    }
    
    private func setDeckTitleTextFieldConstraints() {
        addSubview(deckTitleTextField)
        NSLayoutConstraint.activate([
            deckTitleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            deckTitleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            deckTitleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        
        ])
    }
    
    private func setDeckDescriptionTextFieldConstraints() {
        addSubview(deckDescriptionTextField)
        NSLayoutConstraint.activate([
            deckDescriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            deckDescriptionTextField.topAnchor.constraint(equalTo: deckTitleTextField.bottomAnchor, constant: 16),
            deckDescriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
    }
    
    private func setTitleLabelConstraints() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    
    
    
    
}
