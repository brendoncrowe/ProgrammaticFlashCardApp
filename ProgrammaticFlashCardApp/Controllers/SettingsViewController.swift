//
//  SettingsViewController.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/27/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let settingsView = SettingsView()
    
    
    override func loadView() {
        super.loadView()
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        settingsView.colorSegmentControl.addTarget(self, action: #selector(saveColor), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadColor()
    }
    
    @objc private func saveColor() {
        settingsView.configureColorViewBackgroundColor(settingsView.colorSegmentControl.selectedSegmentIndex)
        UserDefaults.standard.set(settingsView.colorSegmentControl.selectedSegmentIndex, forKey: UserPreferences.index)
    }
    
    private func loadColor() {
        guard let index = UserDefaults.standard.object(forKey: UserPreferences.index) as? Int else {
            settingsView.configureColorViewBackgroundColor() // load default color with 0
            return
        }
        settingsView.configureColorViewBackgroundColor(index) // load color with saved index/Int
    }
}

