//
//  File.swift
//  DodgeCoinTracker
//
//  Created by Asad on 03/06/2021.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    struct Constats {
        static let apikey = "a489723d-f81b-4485-8f2c-e10da4a4fbe1"
        static let url = "https://pro-api-coinmarketcap.com/v1/cryptocurrency/quotes/latest?slug=dogecoin&CMC_PRO_API_KEY=a02d025c-ecb9-4fc1-a1b3-ecf21ed2d41a"
        static let endpoint = "cryptocurrency/quotes/latest"
        static let dodge = "dogecoin"
        static let baseUrl = "https://pro-api.coinmarketcap.com/v1/"
        static let apiHeader = "X-CMC_PRO_API_KEY"
    }
    
    enum APIErrors: Error{
        
        case invalidURL
    }
    
    public func getDodgeCoinData(completion: @escaping ((Result<DogeCoinData,Error>)) -> Void){
        
        guard let url = URL(string: Constats.baseUrl + Constats.endpoint + "?slug=" + Constats.dodge) else {
            completion(.failure(APIErrors.invalidURL))
            return
        }
        
        print("API URL  \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.setValue(Constats.apikey , forHTTPHeaderField: Constats.apiHeader)
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request){ data,_,error in
            
            if let error = error{
                completion(.failure(error))
            }
            guard let data = data else {
                return
                
                
            }
            
            do {
//                let result = try JSONDecoder().decode(DodgeCoinData.self, from: data)
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                
             print(json)
                
                
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                
                guard let dodgeCoinData = response.data.values.first else {
                    return
                }
                
                completion(.success(dodgeCoinData))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
        
        
                                                        
                                                        
                                                        }
}
