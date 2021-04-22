//
//  BreweriesRequest.swift
//  Breweries
//
//  Created by Michael Gable on 4/22/21.
//

import Foundation

typealias breweriesOnCompletion = (Result<[BreweryModel],ResponseErrorType>) -> Void

enum ResponseErrorType: Error {
    case noDataFound
    case decodingError
    case responseError
}

class BreweriesRequest {
    
    let urlString = "https://api.openbrewerydb.org/breweries"
    
    ///Make API call to fetch breweries
    func fetchBreweries(onCompletion: @escaping breweriesOnCompletion) {
        
        guard let url = URL(string: urlString) else {
            print("Cannot form URL")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data,_,error in
            
            if error != nil {
                onCompletion(.failure(.responseError))
                return
            }
            
            guard let json = data else {
                print("no data returned")
                onCompletion(.failure(.noDataFound))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let breweries = try decoder.decode([BreweryModel].self, from: json)
                onCompletion(.success(breweries))
            } catch {
                onCompletion(.failure(.decodingError))
                print("Unable to decode JSON")
            }
        }
        
        dataTask.resume()
        
    }
    
    
    
}
