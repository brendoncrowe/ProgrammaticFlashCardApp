//
//  FlashCardCell.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/23/23.
//

import UIKit


class FlashCardCell: UICollectionViewCell {
    
    public lazy var flashCardQuestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.text = "Question"
        label.numberOfLines = 0
        return label
    }()
    
    
    public lazy var flashCardAnswerLabel: UILabel = {
        let answer = UILabel()
        answer.translatesAutoresizingMaskIntoConstraints = false
        answer.font = UIFont.preferredFont(forTextStyle: .body)
        answer.isHidden = true
        answer.layer.cornerRadius = 8
        answer.numberOfLines = 8
        return answer
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
        setFlashCardQuestionLabel()
        setFlashCardAnswerLabel()
    }
    
    private func setFlashCardQuestionLabel() {
        addSubview(flashCardQuestionLabel)
        NSLayoutConstraint.activate([
            flashCardQuestionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            flashCardQuestionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            flashCardQuestionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            flashCardQuestionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func setFlashCardAnswerLabel() {
        addSubview(flashCardAnswerLabel)
        NSLayoutConstraint.activate([
            flashCardAnswerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            flashCardAnswerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            flashCardAnswerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            flashCardAnswerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    public func configureCell(for flashCard: FlashCard) {
        flashCardQuestionLabel.text = flashCard.question
        flashCardAnswerLabel.text = flashCard.answer
    }
}
