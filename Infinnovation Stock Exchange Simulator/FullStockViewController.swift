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
    var detailedStock: DetailedStockItem?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet var profile: UILabel!
    
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

        // Do any additional setup after loading the view.
        var triangle = "▼"
        
        difference.textColor = .red
        
        if(stock!.gain) {
            difference.textColor = .green
            triangle = "▲"
        }
        
        name.text = stock!.name
        current.text = "₹\(stock!.current)"
        difference.text = "\(triangle) ₹\(stock!.difference)"
        percentage.text = "\(stock!.percentage)%"
        
        detailedStock = getDetailedStockItem()
        profile.text = "\(detailedStock!.profile)"
        pclose.text = "₹\(detailedStock!.pclose)"
        ovalue.text = "₹\(detailedStock!.ovalue)"
        lcircuit.text = "₹\(detailedStock!.lcircuit)"
        ucircuit.text = "₹\(detailedStock!.ucircuit)"
        dividend.text = "₹\(detailedStock!.dividend)"
        bvalue.text = "₹\(detailedStock!.bvalue)"
        
        activity.stopAnimating()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // enables the navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getDetailedStockItem() -> DetailedStockItem {
        return stock as! DetailedStockItem
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
