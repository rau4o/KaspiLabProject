//
//  Indent.swift
//  MyNotes
//
//  Created by rau4o on 7/17/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class Screen {
    class func width() -> CGFloat { return UIScreen.main.bounds.width }
    class func height() -> CGFloat { return UIScreen.main.bounds.height }
}

class Indent {
    class func offset() -> CGFloat { return Screen.width() * 0.042 }
    
    class func hugeOffset() -> CGFloat { return Screen.width() * 0.075 }
    
    class func superSmallOffset() -> CGFloat { return Screen.width() * 0.025 }
    
    class func superPuperSmallOffset() -> CGFloat { return Indent.superSmallOffset() / 2 }
}
