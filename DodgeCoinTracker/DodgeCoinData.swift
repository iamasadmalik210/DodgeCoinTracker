//
//  File.swift
//  DodgeCoinTracker
//
//  Created by Asad on 03/06/2021.
//

import Foundation

struct APIResponse:Decodable {
    let data: [Int:DogeCoinData]
    
}


struct DogeCoinData:Decodable {
    
    let id:Int
    let name: String
    let symbol: String
    let date_added: String
    let tags: [String]
    let total_supply: Float
    let quote: [String:Quote]
    
    
    
}
struct Quote: Decodable{
    
    let price: Float
    
    let volume_24h:Float
}




