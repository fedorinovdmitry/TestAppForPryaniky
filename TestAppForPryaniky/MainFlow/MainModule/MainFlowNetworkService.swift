//
//  MainModuleNetworkService.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 28.09.2020.
//

import Foundation

protocol MainModuleNetworkService {
    func getMainList(completion: @escaping (MainResponce?) -> Void)
}

class MainModuleNetworkServiceImpl: MainModuleNetworkService {
    
    // MARK: - Constants
    
    let mainListUrl = "https://pryaniky.com/static/json/sample.json"

    // MARK: - Depencies

    var networkDataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = dataFetcher
    }
    
    func getMainList(completion: @escaping (MainResponce?) -> Void) {
        networkDataFetcher.fetchJSONData(urlString: mainListUrl, response: completion)
    }
}
