//
//  UnkeyedDecodingContainer+Skip.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 28.09.2020.
//

import Foundation

fileprivate struct Empty: Decodable {}

extension UnkeyedDecodingContainer {
    public mutating func skip() throws {
        _ = try decode(Empty.self)
    }
}
