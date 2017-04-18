//
//  DetailsViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 03/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var stocks: [StockItem] = [StockItem]()
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // serialise the json response into StockItem array
        let apiCall: StocksProfileListAPICall = StocksProfileListAPICall(urlString: "https://infisesapitest-swghosh.rhcloud.com/api/stockslist", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC")
        if apiCall.performApiCall() != nil {
            stocks = apiCall.getStocksList()
            
            time.text = apiCall.time!
            
            activity.stopAnimating()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // disables the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Conforms to the UITableViewDataSource protocol
        var cell: UITableViewCell
        cell = getDetailedStockCell(tableView, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 170.0
        let height = UITableViewAutomaticDimension
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier = "FullStockFromDetails"
        performSegue(withIdentifier: segueIdentifier, sender: stocks[indexPath.row])
    }
    
    func getDetailedStockCell(_ tableView: UITableView, index: Int) -> DetailedStockTableViewCell {
        let cellIdentifier = "Detail"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! DetailedStockTableViewCell
        
        let stock = stocks[index]
        var triangle = "▼"
        
        cell.difference.textColor = .red
        
        if(stock.gain) {
            cell.difference.textColor = .green
            triangle = "▲"
        }
        
        cell.name.text = stock.name
        cell.current.text = "₹\(stock.current)"
        cell.difference.text = "\(triangle) ₹\(stock.difference)"
        cell.percentage.text = "\(stock.percentage)%"
        cell.profile.text = "\(stock.profile!)"
        cell.sector.text = "\(stock.sector)"
        
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "FullStockFromDetails" {
            let destinationViewController = segue.destination as! FullStockViewController
            destinationViewController.stock = sender as? StockItem
        }
    }

}
