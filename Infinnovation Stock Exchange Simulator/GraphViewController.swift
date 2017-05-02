//
//  GraphViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 24/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    var stock: StockItem?
    var updates: [UpdateItem] = [UpdateItem]()
    
    @IBOutlet weak var graphView: GraphView!
    
    func fetchAndSetup() {
        let parentVC = self.parent as? FullStockViewController
        // serialise the json response into StockItem array
        let apiCall: UpdatesListAPICall = UpdatesListAPICall(urlString: "https://infisesapi-vistas.rhcloud.com/api/updateslist", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC", stock: stock!)
        if apiCall.performApiCall() != nil {
            updates = apiCall.getUpdatesList()
            parentVC?.time.text = apiCall.time!
        }
        else {
            parentVC?.displayNoInternet()
            return
        }
        
        var currents = [Int]()
        for item in updates {
            currents.append(item.current)
        }
        let lvalue = currents.min()!
        let hvalue = currents.max()!
        
        parentVC?.hvalue.text = "₹\(hvalue)"
        parentVC?.lvalue.text = "₹\(lvalue)"
        
        graphView.currents = currents
        graphView.lvalue = lvalue
        graphView.hvalue = hvalue
        
        for view in graphView.subviews {
            view.removeFromSuperview()
        }
        
        graphView.setNeedsDisplay()
        
        var i = 0
        parentVC?.infoControl.removeAllSegments()
        while (i < updates.count) {
            parentVC?.infoControl.insertSegment(withTitle: "\(i)", at: i, animated: true)
            i = i + 1
        }
        
        parentVC?.updates = updates
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchAndSetup()
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
