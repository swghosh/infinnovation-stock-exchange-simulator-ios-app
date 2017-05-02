//
//  GraphViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 24/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    // stores a StockItem as received from segue
    var stock: StockItem?
    // stores an array of UpdateItem(s) based on data received from JSON using API call
    var updates: [UpdateItem] = [UpdateItem]()
    
    // IB outlet
    @IBOutlet weak var graphView: GraphView!
    
    func fetchAndSetup() {
        // parent view controller is Full Stock view controller
        // this view controller is a of a container view of Full Stock view
        let parentVC = self.parent as? FullStockViewController
        // makes an API call to fetch JSON data
        let apiCall: UpdatesListAPICall = UpdatesListAPICall(urlString: "https://infisesapi-vistas.rhcloud.com/api/updateslist", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC", stock: stock!)
        // in case the apiCall doesn't return nil
        if apiCall.performApiCall() != nil {
            // serialise the json response into FullStockItem array
            updates = apiCall.getUpdatesList()
            // updates the text string in the time label with the time specified in response JSON
            parentVC?.time.text = apiCall.time!
        }
        else {
            // displays appropriate alert to show that internet connectivity isn't available
            parentVC?.displayNoInternet()
            // ends the function prematurely
            return
        }
        
        // stores an array of current values for current stock
        var currents = [Int]()
        // loop to iterate each UpdateItem in updates array and store its current in currents array
        for item in updates {
            currents.append(item.current)
        }
        // set the high and low values based on current's highest and lowest values
        let lvalue = currents.min()!
        let hvalue = currents.max()!
        
        // sets the high, low values in appropriate labels
        parentVC?.hvalue.text = "₹\(hvalue)"
        parentVC?.lvalue.text = "₹\(lvalue)"
        
        // passes the required data to Graph view for plotting / drawing the appropriate graph
        graphView.currents = currents
        graphView.lvalue = lvalue
        graphView.hvalue = hvalue
        
        // clears all subview in graph view before drawing of actual graph may proceed
        for view in graphView.subviews {
            view.removeFromSuperview()
        }
        
        // asks the Graph view to re render itself based on data passed and call draw function to plot graph
        graphView.setNeedsDisplay()
        
        // loop counter
        var i = 0
        parentVC?.infoControl.removeAllSegments()
        // associates segments to segmented control
        while (i < updates.count) {
            parentVC?.infoControl.insertSegment(withTitle: "\(i)", at: i, animated: true)
            
            // loop counter is incremented
            i = i + 1
        }
        
        // passes the updates array to Full Stock view controller also
        parentVC?.updates = updates
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // fetches data from API Call, parse/serialises the JSON and then updates view with data obtained
        fetchAndSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
