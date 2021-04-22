//
//  BreweryModel.swift
//  Breweries
//
//  Created by Michael Gable on 4/22/21.
//

import Foundation

struct BreweryModel: Codable {
    var name: String
    var street: String
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case street
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        street = try values.decodeIfPresent(String.self, forKey: .street) ?? ""
    }
}
