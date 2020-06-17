//
//  UILabel + Extension.swift
//  MyNotes
//
//  Created by rau4o on 6/17/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

extension UILabel {
    public convenience init(font: UIFont,textAlignment: NSTextAlignment){
        self.init()
        self.font = font
        self.textAlignment = textAlignment
    }
}
