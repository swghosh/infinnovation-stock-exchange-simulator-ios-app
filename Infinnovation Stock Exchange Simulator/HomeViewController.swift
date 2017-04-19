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
    @IBOutlet weak var stocksTableView: UITableView!
    
    var stocks: [StockItem] = [StockItem]()
    var stocksSortBySector: [[StockItem]] = [[StockItem]]()
    
    func fetchAndSetupTable() {
        // serialise the json response into StockItem array
        let apiCall: StocksListAPICall = StocksListAPICall(urlString: "https://infisesapitest-swghosh.rhcloud.com/api/stockslist", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC")
        if apiCall.performApiCall() != nil {
            stocks = apiCall.getStocksList()
            
            time.text = apiCall.time!
            
        }
        else {
            // in case of JSON fetch error
            return
        }
        _ = sortStocksBySector()
        stocksTableView.reloadData()
    }
    
    func sortStocksBySector() -> [[StockItem]] {
        // sort the stocks sector wise
        stocksSortBySector = [[StockItem]]()
        var i = -1
        var sectorName = ""
        for stock in stocks {
            if stock.sector != sectorName {
                stocksSortBySector.append([StockItem]())
                i = i + 1
                sectorName = stock.sector
            }
            stocksSortBySector[i].append(stock)
        }
        return stocksSortBySector
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchAndSetupTable()
        activity.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // disables the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // starts animating the activity indicator
        activity.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Conforms to the UITableViewDataSource protocol
        let cellIdentifier = "Stock"
        let cell: StockTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! StockTableViewCell
        
        let stock = stocksSortBySector[indexPath.section][indexPath.row]
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
        return stocksSortBySector[section].count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier = "FullStockFromHome"
        performSegue(withIdentifier: segueIdentifier, sender: stocksSortBySector[indexPath.section][indexPath.row])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocksSortBySector.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return stocksSortBySector[section][0].sector
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FullStockFromHome"  {
            let destinationViewController = segue.destination as! FullStockViewController
            destinationViewController.stock = sender as? StockItem
        }
    }

}

