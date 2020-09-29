//
//  ContentType.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 28.09.2020.
//

import Foundation

enum ContentType: String, CaseIterable {
    case picture
    case hz
    case selector
    case unknown
    
    static func enumFrom(string: String) -> ContentType? {
        for type in ContentType.allCases {
            if type.rawValue == string {
                return type
            }
        }
        return nil
    }
    
    static func enumFromString(array: [String]) -> [ContentType] {
        var contentTypeArray = [ContentType]()
        for string in array {
            if let type = enumFrom(string: string) {
                contentTypeArray.append(type)
            }
        }
        return contentTypeArray
    }
}

extension CommonContentFromPryaniki {

    var type: ContentType {
        switch name {
        case "hz":
            return .hz
        case "picture":
            return .picture
        case "selector":
            return .selector
        default:
            return .unknown
        }
    }
    
}
