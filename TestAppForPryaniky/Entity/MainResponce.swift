//
//  MainResponce.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 28.09.2020.
//

import Foundation

// MARK: - MainResponce

struct MainResponce: Decodable {
    
    var content: [CommonContentType]
    var view: [ContentType]
    
    enum MainResponceKeys: CodingKey {
        case data
        case view
    }
    
    enum ContentKeys: CodingKey {
        case name
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MainResponceKeys.self)
        view = ContentType.enumFromString(array: try container.decode ([String].self, forKey: .view))
        var contentArrayForType = try container.nestedUnkeyedContainer(forKey: MainResponceKeys.data)
        var content = [CommonContentType]()
        
        var contentArray = contentArrayForType
        while(!contentArrayForType.isAtEnd) {
            let item = try contentArrayForType.nestedContainer(keyedBy: ContentKeys.self)
            let type = ContentType.enumFrom(string: try item.decode(String.self, forKey: ContentKeys.name))
            switch type {
            case .picture:
                content.append(try contentArray.decode(PictureType.self))
            case .hz:
                content.append(try contentArray.decode(SimpleType.self))
            case .selector:
                content.append(try contentArray.decode(SelectorType.self))
            default:
                try contentArray.skip()
            }
            
        }
        self.content = content
    }
    
}

protocol CommonContentType: Decodable {
    var name: String { get }
}


// MARK: - Simple type (hz)

struct SimpleType: CommonContentType {
    var name: String
    var data: HzDataType
}
struct HzDataType: Decodable {
    var text: String
}

// MARK: - Picture type (picture)

struct PictureType: CommonContentType {
    var name: String
    var data: PictureDataType
}
struct PictureDataType: Decodable {
    var url: String
    var text: String
}

// MARK: - Selector type (selector)

struct SelectorType: CommonContentType {
    var name: String
    var data: SelectorDataType
}
struct SelectorDataType: Decodable {
    var selectedId: Int
    var variants: [Variant]
}
struct Variant: Decodable {
    var id: Int
    var text: String
}

