//
//  ViewController.swift
//  Breweries
//
//  Created by Michael Gable on 4/22/21.
//

import UIKit

//display name and address of each brewery

final class ViewController: UITableViewController {
    
    var breweries = [BreweryModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let cellIdentifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Breweries"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        fetchBreweries()
                
    }
    
    private func fetchBreweries() {
        let breweriesHandler = BreweriesRequest()
        
        breweriesHandler.fetchBreweries {[weak self] (result) in
            
            switch result {
            case .failure(let error):
                
                //Can perform different behavior based on error type
                switch error {
                case .decodingError:
                    print("Decoding Error")
                case .noDataFound:
                    print("No data received")
                case .responseError:
                    print("Error in response")
                }
                
            case .success(let breweries):
                self?.breweries = breweries
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breweries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        cell?.textLabel?.text = breweries[indexPath.row].name
        cell?.detailTextLabel?.text = breweries[indexPath.row].street
        
        return cell ?? UITableViewCell()
    }


}

