//
//  WelcomeViewController.swift
//  TanksModeling
//
//  Created by Aliaksei Piatyha on 11/21/18.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import AVFoundation

class WelcomeViewController: UIViewController {

    @IBOutlet weak var imageCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTrailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageCenterYConstraint.constant = -50
        imageTrailingConstraint.constant = 120
        
        UIView.animate(withDuration: 1.5) {
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - Navigation
    
   
    
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "Main", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToModeling",
            let modelingVC = segue.destination as? ModelingViewController {
            modelingVC.settingsModel = SettingsModel()
        }
    }

}
