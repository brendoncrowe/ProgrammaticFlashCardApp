//
//  SettingsViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/27/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
     var settingsView = SettingsView()
    
    
    
    override func loadView() {
        super.loadView()
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        settingsView.colorSegmentControl.addTarget(self, action: #selector(printColor), for: .valueChanged)
    }
    
    @objc func printColor() {
        settingsView.configureColorViewBackgroundColor(settingsView.colorSegmentControl)
    }


}

