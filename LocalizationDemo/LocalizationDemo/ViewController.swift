//
//  ViewController.swift
//  LocalizationDemo
//
//  Created by Mehul Jadav on 08/08/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblHeader            : UILabel!
    @IBOutlet weak var btnChangeLangauge    : UIButton!
    @IBOutlet weak var lblCurrentLanguage   : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblHeader.text             = "header_text".localizedString()
        self.lblCurrentLanguage.text    = LocalizationSystem.sharedInstance.getLanguage()
        self.btnChangeLangauge.setTitle("change_language".localizedString(), for: .normal)
    }
}

//MARK:- IBAction Methods

extension ViewController {

    @IBAction func changeLanguage(_ sender: Any) {
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        } else {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let appDlg = UIApplication.shared.delegate as? AppDelegate
        appDlg?.window?.rootViewController = vc
    }
    
}
