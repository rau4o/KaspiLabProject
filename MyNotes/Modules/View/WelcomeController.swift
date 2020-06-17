//
//  WelcomeController.swift
//  MyNotes
//
//  Created by rau4o on 5/31/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

//func generatePassword(passwordLength: Int) -> String {
//
//    let passwordMaterial : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//    let passwordMaterialLength = UInt32(passwordMaterial.length)
//    
//    var returnValue = ""
//
//    for _ in 0 ..< passwordLength {
//        let randomPosition = arc4random_uniform(passwordMaterialLength)
//        var character = passwordMaterial.character(at: Int(randomPosition))
//        returnValue += NSString(characters: &character, length: 1) as String
//    }
//
//    return returnValue
//}
//let myPassword = generatePassword(passwordLength: 10)
//print("Secure password: \(myPassword)")

