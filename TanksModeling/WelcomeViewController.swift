//
//  WelcomeViewController.swift
//  TanksModeling
//
//  Created by Aliaksei Piatyha on 11/21/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var imageCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTrailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageCenterYConstraint.constant = -70
        imageTrailingConstraint.constant = 120
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToModeling",
            let modelingVC = segue.destination as? ModelingViewController {
            modelingVC.settingsModel = SettingsModel()
        }
    }

}
