//
//  MainResponce.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 28.09.2020.
//

import Foundation

// MARK: - MainResponce

struct MainResponce: Decodable {
    
    var content: [CommonContentFromPryaniki]
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
        var content = [CommonContentFromPryaniki]()
        
        var contentArray = contentArrayForType
        while(!contentArrayForType.isAtEnd) {
            let item = try contentArrayForType.nestedContainer(keyedBy: ContentKeys.self)
            let type = ContentType.enumFrom(string: try item.decode(String.self, forKey: ContentKeys.name))
            switch type {
            case .picture:
                content.append(try contentArray.decode(PictureType.self))
            case .hz:
                let check = try contentArray.decode(SimpleType.self)
                //разкоментите, чтобы проаверить динамический размер ячейки, только лет на вар смените
//                check.data.text = "213213123123jkh3kj13gh21g3kj12h3jk2h13jk2h13kj23ghj12 2h13k 12j3 h12 kh3j1k 3 k1j"
                content.append(check)
            case .selector:
                content.append(try contentArray.decode(SelectorType.self))
            default:
                try contentArray.skip()
            }
            
        }
        self.content = content
    }
    
}

protocol CommonContentFromPryaniki: Decodable {
    var name: String { get }
}

// MARK: - Simple type (hz)

struct SimpleType: CommonContentFromPryaniki {
    var name: String
    var data: HzDataType
}
struct HzDataType: Decodable {
    var text: String
}

// MARK: - Picture type (picture)

struct PictureType: CommonContentFromPryaniki {
    var name: String
    var data: PictureDataType
}
struct PictureDataType: Decodable {
    var url: String
    var text: String
}

// MARK: - Selector type (selector)

struct SelectorType: CommonContentFromPryaniki {
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

