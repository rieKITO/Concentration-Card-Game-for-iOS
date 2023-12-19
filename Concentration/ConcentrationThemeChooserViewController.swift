//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Alexander	 on 16.12.2023.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    let themes = [
        "Animals": ("🦊🐻🦁🦄🐝🦖🐵🐙🐬🐼🐸🕷",  #colorLiteral(red: 0.6784313725, green: 0.8470588235, blue: 0.9019607843, alpha: 1), #colorLiteral(red: 0.4039215686, green: 0.5215686275, blue: 0.7647058824, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.9725490196, blue: 1, alpha: 1)),
        "Food": ("🥐🥞🥓🌶🍥🍭🍞🍕🌮🍔🍙🍪", #colorLiteral(red: 1, green: 0.6274509804, blue: 0.4784313725, alpha: 1), #colorLiteral(red: 1, green: 0.3882352941, blue: 0.2784313725, alpha: 1), #colorLiteral(red: 1, green: 0.9803921569, blue: 0.8039215686, alpha: 1)),
        "Figures": ("⬜️⬛️🟪🔻🔵🔘🔷🔶🟢🟣🔺🔳", #colorLiteral(red: 0.5647058824, green: 0.9333333333, blue: 0.5647058824, alpha: 1), #colorLiteral(red: 0.1803921569, green: 0.5450980392, blue: 0.3411764706, alpha: 1), #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.862745098, alpha: 1))
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
