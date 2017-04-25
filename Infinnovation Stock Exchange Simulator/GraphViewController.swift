//
//  GraphViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 24/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stock: StockItem?
    var updates: [UpdateItem] = [UpdateItem]()
    
    @IBOutlet weak var updatesTableView: UITableView!
    @IBOutlet weak var time: UILabel!
    
    func fetchAndSetup() {
        // serialise the json response into StockItem array
        let apiCall: UpdatesListAPICall = UpdatesListAPICall(urlString: "https://infisesapi-vistas.rhcloud.com/api/updateslist", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC", stock: stock!)
        if apiCall.performApiCall() != nil {
            updates = apiCall.getUpdatesList()
            
            time.text = apiCall.time!
            
        }
        else {
            let parentVC = self.parent as? FullStockViewController
            parentVC?.displayNoInternet()
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchAndSetup()
        updatesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Update"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        cell!.textLabel!.text = "\(updates[indexPath.row].time): ₹\(updates[indexPath.row].current)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updates.count
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
