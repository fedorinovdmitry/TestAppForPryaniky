//
//  NetworkDataFetcher.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 28.09.2020.
//

import Foundation

protocol DataFetcher {
    func fetchJSONData<T: Decodable>(urlString: String,
                                     response: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcher {

    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchJSONData<T: Decodable>(urlString: String,
                                     response: @escaping (T?) -> Void) {
        
        networking.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }

            
            let decoded = self.decodeJSON(type: T.self,
                                          from: data)
            response(decoded)

        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type,
                                  from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self,
                                             from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
