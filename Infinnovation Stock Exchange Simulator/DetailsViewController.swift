//
//  DetailsViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 03/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // stores an array of StockItem(s) based on data fetched from JSON using API calls
    var stocks: [StockItem] = [StockItem]()
    
    // IB outlets
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var detailsTableView: UITableView!
    
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
        let apiCall: StocksProfileListAPICall = StocksProfileListAPICall(urlString: "https://sesapi.infinnovation.co/api/stockslist", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC")
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
        // asks the table view to reload all data based on the new data that has been fetched
        detailsTableView.reloadData()
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
        var cell: UITableViewCell
        // a cell with all required data is obtained
        cell = getDetailedStockCell(tableView, index: indexPath.row)
        // returns the required cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // conforms to UITableViewDataSource protocol
        
        // returns the total number of rows
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // conforms to UITableViewDataSource protocol
        
        // sets estimated row height
        tableView.estimatedRowHeight = 170.0
        // makes sure that each cell has dynamic height as per auto layout
        let height = UITableViewAutomaticDimension
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // conforms to UITableViewDataSource protocol
        let segueIdentifier = "FullStockFromDetails"
        // performs a segue when a table cell is selected
        // the corresponding StockItem for the cell is passed as segue sender
        performSegue(withIdentifier: segueIdentifier, sender: stocks[indexPath.row])
    }
    
    func getDetailedStockCell(_ tableView: UITableView, index: Int) -> DetailedStockTableViewCell {
        let cellIdentifier = "Detail"
        // obtain a protototype cell specified in IB
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! DetailedStockTableViewCell
        
        // the current StockItem whose data is to be shown in the current cell
        let stock = stocks[index]
        // specifies an inverted triangle symbol to signify loss in stock
        var triangle = "▼"
        
        // sets a label to have red color
        cell.difference.textColor = .red
        
        // in case the stock has gain
        if(stock.gain) {
            // sets a label to have green color
            cell.difference.textColor = .green
            // specifies a trinagle symbol to signify gain in stock
            triangle = "▲"
        }
        
        // sets the appropriate labels with the appropriate data for the current stock
        cell.name.text = stock.name
        cell.current.text = "₹\(stock.current)"
        cell.difference.text = "\(triangle) ₹\(stock.difference)"
        cell.percentage.text = "\(stock.percentage)%"
        cell.profile.text = "\(stock.profile!)"
        cell.sector.text = "\(stock.sector)"
        
        // returns the required cell
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare for a segue to be performed
        if segue.identifier == "FullStockFromDetails" {
            // the destination view controller for the segue is obtained
            let destinationViewController = segue.destination as! FullStockViewController
            // the destination view controller's stock value is set to required stock item received from the sender
            destinationViewController.stock = sender as? StockItem
        }
    }

}
