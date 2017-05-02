//
//  FullStockViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 05/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class FullStockViewController: UIViewController {
    
    var stock: StockItem?
    var fullStock: FullStockItem?
    
    var updates: [UpdateItem]?
    
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
    
    var internetConnPresent: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = stock!.name
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
    }
    
    func fetchAndSetup() {
        
        // serialise the json response into StockItem array
        let apiCall: FullStockAPICall = FullStockAPICall(urlString: "https://infisesapi-vistas.rhcloud.com/api/fullstock", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC", stock: stock!)
        if apiCall.performApiCall() != nil {
            fullStock = apiCall.getFullStock()
            
            time.text = apiCall.time!
            
            var triangle = "▼"
            
            difference.textColor = .red
            
            if(fullStock!.gain) {
                difference.textColor = .green
                triangle = "▲"
            }
            
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
            
            internetConnPresent = true
            
        }
        else {
            // in case of JSON fetch error
            if internetConnPresent {
                internetConnPresent = false
                displayNoInternet()
            }
            return
        }
        
    }
    
    func displayNoInternet() {
        let alertController = UIAlertController(title: "Network Issue", message: "No internet connection is currently available. Please make sure that you have a working internet connection in order to use this application.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay!", style: .default, handler: { (action: UIAlertAction) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alertController, animated: true, completion: nil)
        time.text = "No Internet Connectivity"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchAndSetup()
        // puts the scroll view back to normal and unhides it
        scrollView.isUserInteractionEnabled = true
        scrollView.alpha =  1.0
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
        let selectedIndex = sender.selectedSegmentIndex
        let alertController = UIAlertController(title: "\(stock!.name)", message: "At \(updates![selectedIndex].time), \(stock!.name) securities were priced at ₹\(updates![selectedIndex].current).", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Okay!", style: .default, handler: nil)
        alertController.addAction(action)
        alertController.popoverPresentationController?.sourceView = self.infoControl
        
        self.present(alertController, animated: true, completion: { () -> Void in
            self.infoControl.selectedSegmentIndex = -1
        })
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "GraphFromFullStock" {
            let destinationViewController = segue.destination as! GraphViewController
            destinationViewController.stock = stock
        }
    }

}
