//
//  SettingsView.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/27/23.
//

import UIKit

struct UserPreferences {
    static let index = "SegmentIndex"
}

class SettingsView: UIView {
    
    public lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.alpha = 0.5
        label.numberOfLines = 1
        label.text = "choose a card color"
        label.textAlignment = .center
        return label
    }()
    
    public lazy var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        return view
    }()
    
    public lazy var colorSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Blue", "Green", "Yellow", "Red"])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.setTitle("Blue", forSegmentAt: 0)
        segmentControl.setTitle("Green", forSegmentAt: 1)
        segmentControl.setTitle("Yellow", forSegmentAt: 2)
        segmentControl.setTitle("Red", forSegmentAt: 3)
        return segmentControl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.layer.cornerRadius = 16
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
        setLabelConstraints()
        setColorViewConstraints()
        setSegmentControlConstraints()
        configureColorViewBackgroundColor(colorSegmentControl.selectedSegmentIndex)
    }
    
    private func setLabelConstraints() {
        addSubview(colorLabel)
        NSLayoutConstraint.activate([
            colorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40)
        ])
    }
    
    private func setColorViewConstraints() {
        addSubview(colorView)
        NSLayoutConstraint.activate([
            colorView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            colorView.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.8),
            colorView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 8),
            colorView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setSegmentControlConstraints() {
        addSubview(colorSegmentControl)
        NSLayoutConstraint.activate([
            colorSegmentControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorSegmentControl.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 16)
        ])
    }
    
    public func configureColorViewBackgroundColor(_ index: Int = 0) {
        switch index {
        case 0:
            colorView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.6)
            colorSegmentControl.selectedSegmentIndex = 0
        case 1:
            colorView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.6)
            colorSegmentControl.selectedSegmentIndex = 1
        case 2:
            colorView.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.6)
            colorSegmentControl.selectedSegmentIndex = 2
        case 3:
            colorView.backgroundColor = UIColor.systemRed.withAlphaComponent(0.6)
            colorSegmentControl.selectedSegmentIndex = 3
        default:
            return
        }
    }
}
