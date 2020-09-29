//
//  Fonts.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 29.09.2020.
//

import UIKit

extension UIFont {
    
    ///Scale font size throw all app
    static private var fontSize: CGFloat {
        if UIDevice.iPhoneX {
           return UIScreen.main.bounds.height*0.023
        }
        return UIScreen.main.bounds.height*0.027
    }
    
    enum AppFontType {
        case avenir
        case avenirTitle
        case avenirWith(customSize: CGFloat)
        case avenirAnd(customScale: CGFloat)
    }
    
    static func appFont(type: AppFontType) -> UIFont {
        var font: UIFont? = nil
        switch type {
        case .avenir:
            font = UIFont.init(name: "Avenir", size: fontSize)
        case .avenirTitle:
            font = UIFont.init(name: "Avenir Black", size: fontSize+3)
        case .avenirWith(let customSize):
            font = UIFont.init(name: "Avenir", size: customSize)
        case .avenirAnd(let customScale):
            font = UIFont.init(name: "Avenir", size: fontSize*customScale)
        }
        return font == nil ? UIFont.systemFont(ofSize: fontSize) : font!
        
    }
    
}
