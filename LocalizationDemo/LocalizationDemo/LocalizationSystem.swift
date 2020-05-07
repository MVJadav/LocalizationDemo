//
//  AppDelegate.swift
//  LocalizationSystem.swift
//
//  Created by Mehul Jadav on 08/08/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UIKit

class LocalizationSystem:NSObject {

    let AppleLanguages = "AppleLanguages"
    var bundle: Bundle!
    
    class var sharedInstance: LocalizationSystem {
        struct Singleton {
            static let instance: LocalizationSystem = LocalizationSystem()
        }
        return Singleton.instance
    }

    override init() {
        super.init()
        bundle = Bundle.main
    }
    
    func localizedStringForKey(key:String, comment:String) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }
    
    func localizedImagePathForImg(imagename:String, type:String) -> String {
        guard let imagePath =  bundle.path(forResource: imagename, ofType: type) else {
            return ""
        }
        return imagePath
    }
    
//MARK:- setLanguage
// Sets the desired language of the ones you have.
// If this function is not called it will use the default OS language.
// If the language does not exists y returns the default OS language.
    
    func setLanguage(languageCode:String) {
        
        if var appleLanguages = UserDefaults.standard.object(forKey: self.AppleLanguages) as? [String] {
            appleLanguages.remove(at: 0)
            appleLanguages.insert(languageCode, at: 0)
            UserDefaults.standard.set(appleLanguages, forKey: self.AppleLanguages)
            UserDefaults.standard.synchronize()     //needs restrat
            
            if let languageDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj")  {
                bundle = Bundle.init(path: languageDirectoryPath)
            } else {
                resetLocalization()
            }
        }

    }
    
//MARK:- resetLocalization
//Resets the localization system, so it uses the OS default language.
    
    func resetLocalization() {
        bundle = Bundle.main
    }
    
//MARK:- getLanguage
// Just gets the current setted up language.
    
    func getLanguage() -> String {
        
        if let appleLanguages = UserDefaults.standard.object(forKey: self.AppleLanguages) as? [String] {
            let prefferedLanguage = appleLanguages[0]
            if prefferedLanguage.contains("-") {
                let array = prefferedLanguage.components(separatedBy: "-")
                return array[0]
            }
            return prefferedLanguage
        }
        return ""
    }
}

//Get Localize String
extension String {
    func localizedString() -> String {
        return LocalizationSystem.sharedInstance.localizedStringForKey(key: self, comment: "")
    }
}

