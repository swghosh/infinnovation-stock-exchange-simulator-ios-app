//
//  ViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 29/03/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var stocks: [StockItem] = [ StockItem(name: "Bajaj Auto", current: 2990, difference: 0, percentage: 0, sector: "Automotive"), StockItem(name: "Mahindra motors", current: 1320, difference: 100, percentage: 7.04, sector: "Automotive"), StockItem(name: "Maruti Suzuki", current: 5700, difference: -220, percentage: -4.01, sector: "Automotive"), StockItem(name: "Tata motors", current: 600, difference: -45, percentage: -8.11, sector: "Automotive"), StockItem(name: "InterGlobe Aviation", current: 54, difference: 811, percentage: 93.76, sector: "Aviation"), StockItem(name: "Jet Airways", current: 543, difference: -3, percentage: -0.56, sector: "Aviation"), StockItem(name: "SpiceJet", current: 54, difference: 6, percentage: 10, sector: "Aviation"), StockItem(name: "Axis Bank", current: 699, difference: -104, percentage: -17.48, sector: "Banking"), StockItem(name: "Bajaj Finance", current: 2900, difference: 80, percentage: 2.68, sector: "Banking"), StockItem(name: "Bank of Baroda", current: 160, difference: 5, percentage: 3.03, sector: "Banking"), StockItem(name: "HDFC Bank", current: 1230, difference: 50, percentage: 3.91, sector: "Banking"), StockItem(name: "ICICI Bank", current: 276, difference: -6, percentage: -2.22, sector: "Banking"), StockItem(name: "LIC Housing Finance", current: 573, difference: 2, percentage: 0.35, sector: "Banking"), StockItem(name: "SBI", current: 268, difference: -8, percentage: -3.08, sector: "Banking"), StockItem(name: "SBM", current: 205, difference: -205, percentage: 0, sector: "Banking"), StockItem(name: "Yes Bank", current: 1250, difference: -75, percentage: -6.38, sector: "Banking"), StockItem(name: "ACC", current: 1820, difference: -170, percentage: -10.3, sector: "Cement"), StockItem(name: "Gujarat Ambuja", current: 260, difference: 5, percentage: 1.89, sector: "Cement"), StockItem(name: "Ultra Tech Cement", current: 4300, difference: -315, percentage: -7.9, sector: "Cement"), StockItem(name: "BHEL", current: 154, difference: -7, percentage: -4.76, sector: "Engineering and Construction"), StockItem(name: "Larsen", current: 1428, difference: 52, percentage: 3.51, sector: "Engineering and Construction"), StockItem(name: "Siemens", current: 1284, difference: -24, percentage: -1.9, sector: "Engineering and Construction"), StockItem(name: "Asian Paints", current: 1200, difference: -30, percentage: -2.56, sector: "Fast Moving Consumer Goods"), StockItem(name: "Dabur", current: 270, difference: 25, percentage: 8.47, sector: "Fast Moving Consumer Goods"), StockItem(name: "Hind Liver", current: 916, difference: -6, percentage: -0.66, sector: "Fast Moving Consumer Goods"), StockItem(name: "ITC", current: 265, difference: -5, percentage: -1.92, sector: "Fast Moving Consumer Goods"), StockItem(name: "HCL Tech", current: 745, difference: 45, percentage: 5.7, sector: "Information Technology"), StockItem(name: "Infosys", current: 1005, difference: 55, percentage: 5.19, sector: "Information Technology"), StockItem(name: "TCS", current: 2250, difference: 155, percentage: 6.44, sector: "Information Technology"), StockItem(name: "Wipro", current: 495, difference: -15, percentage: -3.13, sector: "Information Technology"), StockItem(name: "GAIL", current: 360, difference: 30, percentage: 7.69, sector: "Oil and Gas"), StockItem(name: "HPCL", current: 440, difference: -35, percentage: -8.64, sector: "Oil and Gas"), StockItem(name: "ONGC", current: 278, difference: -23, percentage: -9.02, sector: "Oil and Gas"), StockItem(name: "Reliance", current: 1075, difference: 5, percentage: 0.46, sector: "Oil and Gas"), StockItem(name: "Cipla", current: 640, difference: -45, percentage: -7.56, sector: "Pharma"), StockItem(name: "Dr. Reddy", current: 3197, difference: -47, percentage: -1.49, sector: "Pharma"), StockItem(name: "Sun Pharma", current: 850, difference: -70, percentage: -8.97, sector: "Pharma"), StockItem(name: "Wockhardt", current: 1000, difference: -110, percentage: -12.36, sector: "Pharma"), StockItem(name: "Bharti Airtel", current: 340, difference: -15, percentage: -4.62, sector: "Telecom"), StockItem(name: "Idea", current: 80, difference: 5, percentage: 5.88, sector: "Telecom"), StockItem(name: "Reliance Communications", current: 50, difference: -1, percentage: -2.04, sector: "Telecom") ]
    
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
//        if(indexPath.row % 5 == 0) {
//            cell = getSectorCell(tableView, index: indexPath.row)
//        }
//        else {
            cell = getStockCell(tableView, index: indexPath.row)
//        }
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

