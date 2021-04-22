//
//  BreweriesModel.swift
//  Breweries
//
//  Created by Michael Gable on 4/22/21.
//

import Foundation

struct BreweryInformation: Codable {
    var name: String
    var address: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case address = "street"
    }
}
