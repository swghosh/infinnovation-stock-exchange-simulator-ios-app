//
//  HeadlinesViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 02/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import Foundation
import UIKit

class HeadlinesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // IB outlets
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var headlinesTableView: UITableView!
    
    // stores an array of NewsItem(s) based on data fetched from JSON using API calls
    var news: [NewsItem] = [NewsItem]()
    
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
        let apiCall: HeadlinesListAPICall = HeadlinesListAPICall(urlString: "https://infisesapi-vistas.rhcloud.com/api/headlineslist", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC")
        // in case the apiCall doesn't return nil
        if apiCall.performApiCall() != nil {
            // serialise the json response into StockItem array
            news = apiCall.getHeadlinesList()
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
        headlinesTableView.reloadData()
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
        // asks the activity indicator view to start animating
        activity.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // asks the timer to dissolve and stop working
        timer?.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // conforms to UITableViewDataSource protocol
        
        // sets estimated row height
        tableView.estimatedRowHeight = 70.0
        // makes sure that each cell has dynamic height as per auto layout
        let height = UITableViewAutomaticDimension
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // conforms to UITableViewDataSource protocol
        
        // returns the total number of rows
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // conforms to UITableViewDataSource protocol
        
        let cellIdentifier = "News"
        // obtain a protototype cell specified in IB
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! NewsTableViewCell
        // sets the appropriate labels with the appropriate data for the current stock
        cell.time.text = news[indexPath.row].time
        cell.news.text = news[indexPath.row].content
        
        // returns the required cell
        return cell
    }
    
}
