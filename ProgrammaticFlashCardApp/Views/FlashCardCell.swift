//
//  FlashCardCell.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/23/23.
//

import UIKit

protocol FlashCardCellDelegate: AnyObject {
    func didSelectMoreButton(_ savedFlashCardCell: FlashCardCell, card: FlashCard)
}



class FlashCardCell: UICollectionViewCell {
    
    // step 2: custom protocol
    weak var delegate: FlashCardCellDelegate?
    
    // to keep track of the current cell's article
    private var currentCard: FlashCard!
    
    public lazy var flashCardQuestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.text = "Question"
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        button.isHidden = true
        button.isEnabled = false
        return button
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
    
    @objc private func moreButtonPressed(_ sender: UIButton) {
        delegate?.didSelectMoreButton(self, card: currentCard)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupMoreButtonConstraints()
        setFlashCardQuestionLabel()
        setFlashCardAnswerLabel()
    }
    
    private func setupMoreButtonConstraints() {
        addSubview(moreButton)
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 44),
            moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor)
        ])
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
        currentCard = flashCard
        flashCardQuestionLabel.text = flashCard.question
        flashCardAnswerLabel.text = flashCard.answer
    }
}
