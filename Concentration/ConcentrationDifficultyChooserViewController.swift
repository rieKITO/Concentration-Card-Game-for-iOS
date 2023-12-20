//
//  ConcentrationDifficultyChooserViewController.swift
//  Concentration
//
//  Created by Alexander	 on 19.12.2023.
//

import UIKit

class ConcentrationDifficultyChooserViewController: UIViewController {
    
    var theme: (String?, UIColor, UIColor, UIColor) = ("Default", .white, .white, .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    let difficulties = [
        "Easy": 8,
        "Medium": 12,
        "Hard": 24
    ]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose difficulty" {
            if let difficultyName = (sender as? UIButton)?.currentTitle, let difficulty = difficulties[difficultyName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.difficulty = difficulty
                    cvc.theme = theme
                }
            }
        }
    }
}
