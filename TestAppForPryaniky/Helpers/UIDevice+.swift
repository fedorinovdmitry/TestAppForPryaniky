//
//  UIDevice.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 29.09.2020.
//

import UIKit
public enum Device {
    case iPhoneSE
    case iPhone8
    case iPhone8plus
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax

    case iPad
    case tv
    case carPlay
    case mac
    
    case unknown
}

public extension UIDevice {
    
    static var iPhone5: Bool { return device == .iPhoneSE }
    static var iPhoneX: Bool { return device == .iPhone11 || device == .iPhone11Pro || device == .iPhone11ProMax }
    static var iPad: Bool { return device == .iPad }
    
    static var device: Device {
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            switch UIScreen.main.nativeBounds.height {
            case 1136:          return .iPhoneSE
            case 1334:          return .iPhone8
            case 1920, 2208:    return .iPhone8plus
            case 1792:          return .iPhone11
            case 2436:          return .iPhone11Pro
            case 2688:          return .iPhone11ProMax
            default:            return .unknown
            }
        case .pad: return .iPad
        case .tv: return .tv
        case .carPlay: return .carPlay
        case .unspecified: return .unknown
        case .mac: return .mac
        @unknown default: return .unknown
        }
    }
    
}
