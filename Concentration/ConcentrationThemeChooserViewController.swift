//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Alexander	 on 16.12.2023.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    let themes = [
        "Animals": ("🦊🐻🦁🦄🐝🦖🐵🐙🐬🐼🐸🕷", #colorLiteral(red: 0.5038267664, green: 0.6173603365, blue: 0.7628291561, alpha: 1), #colorLiteral(red: 0.401989106, green: 0.5202808558, blue: 0.7628291561, alpha: 1), #colorLiteral(red: 0.4469177772, green: 0.7628291561, blue: 0.6397354423, alpha: 1)),
        "Food": ("🥐🥞🥓🌶🍥🍭🍞🍕🌮🍔🍙🍪", #colorLiteral(red: 0.8746629124, green: 0.724582227, blue: 0.3768953192, alpha: 1), #colorLiteral(red: 0.6614054569, green: 0.4781931886, blue: 0.2279217492, alpha: 1), #colorLiteral(red: 0.7056654824, green: 0.6020717044, blue: 0.7628291561, alpha: 1)),
        "Figures": ("⬜️⬛️🟪🔻🔵🔘🔷🔶🟢🟣🔺🔳", #colorLiteral(red: 0.6544869723, green: 0.8746629124, blue: 0.3157800667, alpha: 1), #colorLiteral(red: 0.4349620581, green: 0.6105448921, blue: 0.2223440832, alpha: 1), #colorLiteral(red: 0.5349683594, green: 0.7890155451, blue: 0.8136897208, alpha: 1))
    ]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cdcvc = segue.destination as? ConcentrationDifficultyChooserViewController {
                    cdcvc.theme = theme
                }
            }
        }
    }
}
