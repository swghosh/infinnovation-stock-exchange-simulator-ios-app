//
//  FullStockViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 05/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class FullStockViewController: UIViewController {
    
    // stores a StockItem as received from segue
    var stock: StockItem?
    // stores a FullStockItem based on data fetched from JSON using API call
    var fullStock: FullStockItem?
    
    // stores an array of UpdateItem(s) received from Graph view controller
    var updates: [UpdateItem]?
    
    // IB outlets
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var profile: UILabel!
    @IBOutlet weak var sector: UILabel!
    
    @IBOutlet weak var pclose: UILabel!
    @IBOutlet weak var ovalue: UILabel!
    @IBOutlet weak var lcircuit: UILabel!
    @IBOutlet weak var ucircuit: UILabel!
    @IBOutlet weak var dividend: UILabel!
    @IBOutlet weak var bvalue: UILabel!
    
    @IBOutlet weak var hvalue: UILabel!
    @IBOutlet weak var lvalue: UILabel!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var infoControl: UISegmentedControl!
    
    // stores whether internet connectivity was available or not for the last network request API call
    var internetConnPresent: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets all label texts to have empty values
        name.text = "\(stock!.name)"
        current.text = ""
        difference.text = ""
        percentage.text = ""
        sector.text = "\(stock!.sector)"
        
        profile.text = ""
        pclose.text = ""
        ovalue.text = ""
        lcircuit.text = ""
        ucircuit.text = ""
        dividend.text = ""
        bvalue.text = ""
        lvalue.text = ""
        hvalue.text = ""
    }
    
    func fetchAndSetup() {
        
        // makes an API call to fetch JSON data
        let apiCall: FullStockAPICall = FullStockAPICall(urlString: "https://infisesapi-vistas.rhcloud.com/api/fullstock", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC", stock: stock!)
        // in case the apiCall doesn't return nil
        if apiCall.performApiCall() != nil {
            // serialise the json response into FullStockItem array
            fullStock = apiCall.getFullStock()
            // updates the text string in the time label with the time specified in response JSON
            time.text = apiCall.time!
            
            // specifies an inverted triangle symbol to signify loss in stock
            var triangle = "▼"
            
            // sets a label to have red color
            difference.textColor = .red
            
            // in case the stock has gain
            if(fullStock!.gain) {
                // sets a label to have green color
                difference.textColor = .green
                // specifies a trinagle symbol to signify gain in stock
                triangle = "▲"
            }
            
            // sets the appropriate labels with the appropriate data for the current stock
            name.text = fullStock!.name
            current.text = "₹\(fullStock!.current)"
            difference.text = "\(triangle) ₹\(fullStock!.difference)"
            percentage.text = "\(fullStock!.percentage)%"
            sector.text = "\(fullStock!.sector)"
            
            profile.text = "\(fullStock!.profile!)"
            pclose.text = "₹\(fullStock!.pclose)"
            ovalue.text = "₹\(fullStock!.ovalue)"
            lcircuit.text = "₹\(fullStock!.lcircuit)"
            ucircuit.text = "₹\(fullStock!.ucircuit)"
            dividend.text = "₹\(fullStock!.dividend)"
            bvalue.text = "₹\(fullStock!.bvalue)"
            
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
    }
    
    func displayNoInternet() {
        // initialises a new alert controller
        let alertController = UIAlertController(title: "Network Issue", message: "No internet connection is currently available. Please make sure that you have a working internet connection in order to use this application.", preferredStyle: .alert)
        // adds an action to the alert controller
        alertController.addAction(UIAlertAction(title: "Okay!", style: .default, handler: { (action: UIAlertAction) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        // asks the current view controller to present the alert controller
        self.present(alertController, animated: true, completion: nil)
        // specifies in the time label that there is no internet connectivity available
        time.text = "No Internet Connectivity"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // fetches data from API Call, parse/serialises the JSON and then updates view with data obtained
        fetchAndSetup()
        // puts the scroll view back to normal and unhides it
        scrollView.isUserInteractionEnabled = true
        scrollView.alpha =  1.0
        // asks the activity indicator view to stop animating
        activity.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // enables the navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        // keeps the scroll view hidden
        scrollView.isUserInteractionEnabled = false
        scrollView.alpha =  0.0
        // start animating the activity indicator
        activity.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentedControlPress(_ sender: UISegmentedControl) {
        // index that is selected in segmented control
        let selectedIndex = sender.selectedSegmentIndex
        // initializes an alert controller of style action sheet
        let alertController = UIAlertController(title: "\(stock!.name)", message: "At \(updates![selectedIndex].time), \(stock!.name) securities were priced at ₹\(updates![selectedIndex].current).", preferredStyle: .actionSheet)
        // an alert action for the alert controller
        let action = UIAlertAction(title: "Okay!", style: .default, handler: nil)
        // adds the action to the alert controller
        alertController.addAction(action)
        // sets teh pop over view for the alert controller
        // applicable only in case of iPad
        alertController.popoverPresentationController?.sourceView = self.infoControl
        
        // asks the current view controller to present the alert controller
        self.present(alertController, animated: true, completion: { () -> Void in
            // makes the segmented control to unset selected segment
            self.infoControl.selectedSegmentIndex = -1
        })
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare for segue to be performed
        if segue.identifier == "GraphFromFullStock" {
            // the destination view controller for the segue is obtained
            let destinationViewController = segue.destination as! GraphViewController
            // the destination view controller's stock value is set to required stock item received from the sender
            destinationViewController.stock = stock
        }
    }

}
