//
//  HomeViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 29/03/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // IB outlets
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var stocksTableView: UITableView!
    
    // stores an array of StockItem(s) basesd on data fetched from JSON using API calls
    var stocks: [StockItem] = [StockItem]()
    // stores an array of array of StockItem(s) sorted by sector
    var stocksSortBySector: [[StockItem]] = [[StockItem]]()
    
    // store the last obtained array of sorted array of StockItem(s)
    var prevStocksSortBySector: [[StockItem]] = [[StockItem]]()
    
    // a timer that will repeat a block of code every 10 seconds
    var timer: Timer?
    // stores whether internet connectivity was available or not for the last network request API call
    var internetConnPresent: Bool = true
    
    func setupTimer() {
        // activates the timer to repeat a block of code every 10 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer: Timer) in
            // calls the appropriate function to fetch JSON data from network and update table
            self.fetchAndSetupTable()
        })
    }
    
    func fetchAndSetupTable() {
        // makes an API call to fetch JSON data
        let apiCall: StocksListAPICall = StocksListAPICall(urlString: "https://infisesapi-vistas.rhcloud.com/api/stockslist", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC")
        // in case the apiCall doesn't return nil
        if apiCall.performApiCall() != nil {
            // serialise the json response into StockItem array
            stocks = apiCall.getStocksList()
            // updates the text string in the time label with the time specified in response JSON
            time.text = apiCall.time!
            // specifies that internet connectivity was present
            internetConnPresent = true
        }
        else {
            // in case of JSON fetch error
            if internetConnPresent {
                // specifies that internet connectivity isn't present
                internetConnPresent = false
                // displays appropriate alert to show that internet connectivity isn't available
                displayNoInternet()
            }
            // ends the function prematurely
            return
        }
        // sorts the StockItem(s) array based on sector
        // assuming array is already sector-wise
        _ = sortStocksBySector()
        // asks the table view to reload all data based on the new data that has been fetched
        stocksTableView.reloadData()
    }
    
    func sortStocksBySector() -> [[StockItem]] {
        // keeps a backup copy of the previous array
        prevStocksSortBySector = stocksSortBySector
        // sort the stocks sector wise
        stocksSortBySector = [[StockItem]]()
        
        // loop counter
        var i = -1
        // string variable used to sort
        var sectorName = ""
        for stock in stocks {
            // increments counter when sector name of previous doesn't match current
            if stock.sector != sectorName {
                // appends the required array with iterated StockItem
                stocksSortBySector.append([StockItem]())
                // increments counter
                i = i + 1
                // specifies that the variable have the new sector name
                sectorName = stock.sector
            }
            // appends the required array with iterated StockItem
            stocksSortBySector[i].append(stock)
        }
        // sorted array is returned
        return stocksSortBySector
    }
    
    func displayNoInternet() {
        // initialises a new alert controller
        let alertController = UIAlertController(title: "Network Issue", message: "No internet connection is currently available. Please make sure that you have a working internet connection in order to use this application.", preferredStyle: .alert)
        // adds an action to the alert controller
        alertController.addAction(UIAlertAction(title: "Okay!", style: .default, handler: nil))
        // asks the current view controller to present the alert controller
        self.present(alertController, animated: true, completion: nil)
        // specifies in the time label that there is no internet connectivity available
        time.text = "No Internet Connectivity"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // asks the timer to dissolve and stop working
        timer?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // specifies initially that internet connection should be present
        internetConnPresent = true
        
        // fetches data from API Call, parse/serialises the JSON and then updates table view with data obtained
        fetchAndSetupTable()
        // asks the activity indicator view to stop animating
        activity.stopAnimating()
        
        // sets up a timer that will repeatedly fetch data and update the table view every 10 seconds
        setupTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // disables the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // asks the activity indicator view to start animating
        activity.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // conforms to the UITableViewDataSource protocol
        let cellIdentifier = "Stock"
        // obtain a protototype cell specified in IB
        let cell: StockTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! StockTableViewCell
        
        // the current StockItem whose data is to be shown in the current cell
        let stock = stocksSortBySector[indexPath.section][indexPath.row]
        // specifies an inverted triangle symbol to signify loss in stock
        var triangle = "▼"
        
        // sets a label to have red color
        cell.difference.textColor = .red
        
        // in case the stock has gain
        if(stock.gain) {
            // sets a label to have green color
            cell.difference.textColor = .green
            // specifies a triangle symbol to signify gain in stock
            triangle = "▲"
        }
        
        // sets the appropriate labels with the appropriate data for the current stock
        cell.name.text = stock.name
        cell.current.text = "₹\(stock.current)"
        cell.difference.text = "\(triangle) ₹\(stock.difference)"
        cell.percentage.text = "\(stock.percentage)%"
        
        // to highlight cell in yellow colour in case of price update
        if prevStocksSortBySector.count == stocksSortBySector.count {
            if prevStocksSortBySector[indexPath.section][indexPath.row].current != stock.current {
                // make the cell layer color yellow
                cell.layer.backgroundColor = UIColor.yellow.cgColor
            }
            else {
                // make the cell layer color white (default)
                cell.layer.backgroundColor = UIColor.white.cgColor
            }
        }
        
        // returns the required cell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // conforms to UITableViewDataSource protocol
        
        // returns the total number of rows in the section
        return stocksSortBySector[section].count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // conforms to UITableViewDataSource protocol
        let segueIdentifier = "FullStockFromHome"
        // performs a segue when a table cell is selected
        // the corresponding StockItem for the cell is passed as segue sender
        performSegue(withIdentifier: segueIdentifier, sender: stocksSortBySector[indexPath.section][indexPath.row])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // conforms to UITableViewDataSource protocol
        
        // returns the number of sections
        return stocksSortBySector.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // conforms to UITableViewDataSource protocol
        
        // returns the sector name as title for header in section
        return stocksSortBySector[section][0].sector
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare for a segue to be performed
        if segue.identifier == "FullStockFromHome"  {
            // the destination view controller for the segue is obtained
            let destinationViewController = segue.destination as! FullStockViewController
            // the destination view controller's stock value is set to required stock item received from the sender
            destinationViewController.stock = sender as? StockItem
        }
    }

}

