//
//  FlashCardCell.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/23/23.
//

import UIKit

class FlashCardCell: UICollectionViewCell {
    
    
    private lazy var flashCardQuestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.text = "Question answer"
        
        return label
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
    }
    
    private func setTitleLabelConstraints() {
        addSubview(flashCardQuestionLabel)
        NSLayoutConstraint.activate([
            flashCardQuestionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            flashCardQuestionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            flashCardQuestionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            flashCardQuestionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
    }
    
    public func configureCell(for flashCard: FlashCard) {
        flashCardQuestionLabel.text = flashCard.question
    }
    
}
