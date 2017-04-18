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
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // serialise the json response into StockItem array
        let apiCall: FullStockAPICall = FullStockAPICall(urlString: "https://infisesapitest-swghosh.rhcloud.com/api/fullstock", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC", stock: stock!)
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
            
            activity.stopAnimating()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // enables the navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
