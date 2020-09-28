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
