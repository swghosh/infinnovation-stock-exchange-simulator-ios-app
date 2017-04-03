//
//  ViewController.swift
//  InfiSES
//
//  Created by SwG Ghosh on 29/03/17.
//  Copyright © 2017 codecrafts. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var stocks: [StockItem] = [StockItem(name: "ACC", current: 899, difference: -90, percentage: -3.5, sector: "Cement"), StockItem(name: "Apple", current: 899, difference: 90, percentage: 3.5, sector: "Information Technology"), StockItem(name: "ACC", current: 899, difference: -90, percentage: -3.5, sector: "Cement")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activity.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Conforms to the UITableViewDataSource protocol
        var cell: UITableViewCell
        if(indexPath.row % 5 == 0) {
            cell = getSectorCell(tableView, index: indexPath.row / 5)
        }
        else {
            cell = getStockCell(tableView, index: indexPath.row)
        }
        return cell
        
    }
    
    func getSectorCell(_ tableView: UITableView, index: Int) -> SectorTableViewCell {
        let cellIdentifier = "Sector"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SectorTableViewCell
        
        cell.sectorName.text = stocks[index].sector
        
        return cell
    }
    
    func getStockCell(_ tableView: UITableView, index: Int) -> StockTableViewCell {
        let cellIdentifier = "Stock"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! StockTableViewCell
        
        let stock = stocks[index]
        var triangle = "▼"
        
        cell.difference.textColor = .red
        
        if(stock.gain) {
            cell.difference.textColor = .green
            triangle = "▲"
        }
        
        cell.name.text = stock.name
        cell.current.text = "₹\(stock.current)"
        cell.difference.text = "\(triangle) ₹\(stock.difference)"
        cell.percentage.text = "\(stock.percentage)%"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the total number of rows in the table
        return stocks.count
    }

}

