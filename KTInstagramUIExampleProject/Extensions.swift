//
//  Extensions.swift
//  KTInstagramUIExampleProject
//
//  Created by Craig Holliday on 8/14/17.
//  Copyright © 2017 Koala Tea. All rights reserved.
//

import UIKit

let iphone7Height: CGFloat = 667.0
let iphone7Width: CGFloat = 375.0

extension Int {
    func calculateHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func calculateWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension Double {
    func calculateHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func calculateWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}

extension CGFloat {
    func calculateHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / self
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func calculateWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / self
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}


extension Float {
    func calculateHeight() -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let divisor: CGFloat = iphone7Height / CGFloat(self)
        let calculatedHeight = screenHeight / divisor
        return calculatedHeight
    }
    
    func calculateWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let divisor: CGFloat = iphone7Width / CGFloat(self)
        let calculatedWidth = screenWidth / divisor
        return calculatedWidth
    }
}
