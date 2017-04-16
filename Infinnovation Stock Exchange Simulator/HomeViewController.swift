//
//  ViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 29/03/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var stocks: [StockItem] = [StockItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // json response
        let jsonString: String = "{\"time\":\"16/04/2017 20:06:14\",\"result\":[{\"name\":\"Bajaj Auto\",\"current\":3000,\"difference\":-10,\"percentage\":-0.33,\"sector\":\"Automotive\"},{\"name\":\"Mahindra motors\",\"current\":1320,\"difference\":100,\"percentage\":7.04,\"sector\":\"Automotive\"},{\"name\":\"Maruti Suzuki\",\"current\":5700,\"difference\":-220,\"percentage\":-4.01,\"sector\":\"Automotive\"},{\"name\":\"Tata motors\",\"current\":600,\"difference\":-45,\"percentage\":-8.11,\"sector\":\"Automotive\"},{\"name\":\"InterGlobe Aviation\",\"current\":921,\"difference\":-56,\"percentage\":-6.47,\"sector\":\"Aviation\"},{\"name\":\"Jet Airways\",\"current\":543,\"difference\":-3,\"percentage\":-0.56,\"sector\":\"Aviation\"},{\"name\":\"SpiceJet\",\"current\":62,\"difference\":-2,\"percentage\":-3.33,\"sector\":\"Aviation\"},{\"name\":\"Axis Bank\",\"current\":699,\"difference\":-104,\"percentage\":-17.48,\"sector\":\"Banking\"},{\"name\":\"Bajaj Finance\",\"current\":2900,\"difference\":80,\"percentage\":2.68,\"sector\":\"Banking\"},{\"name\":\"Bank of Baroda\",\"current\":160,\"difference\":5,\"percentage\":3.03,\"sector\":\"Banking\"},{\"name\":\"HDFC Bank\",\"current\":1209,\"difference\":71,\"percentage\":5.55,\"sector\":\"Banking\"},{\"name\":\"ICICI Bank\",\"current\":276,\"difference\":-6,\"percentage\":-2.22,\"sector\":\"Banking\"},{\"name\":\"LIC Housing Finance\",\"current\":573,\"difference\":2,\"percentage\":0.35,\"sector\":\"Banking\"},{\"name\":\"SBI\",\"current\":268,\"difference\":-8,\"percentage\":-3.08,\"sector\":\"Banking\"},{\"name\":\"SBM\",\"current\":205,\"difference\":-205,\"percentage\":0,\"sector\":\"Banking\"},{\"name\":\"Yes Bank\",\"current\":1250,\"difference\":-75,\"percentage\":-6.38,\"sector\":\"Banking\"},{\"name\":\"ACC\",\"current\":1800,\"difference\":-150,\"percentage\":-9.09,\"sector\":\"Cement\"},{\"name\":\"Gujarat Ambuja\",\"current\":260,\"difference\":5,\"percentage\":1.89,\"sector\":\"Cement\"},{\"name\":\"Ultra Tech Cement\",\"current\":4300,\"difference\":-315,\"percentage\":-7.9,\"sector\":\"Cement\"},{\"name\":\"BHEL\",\"current\":154,\"difference\":-7,\"percentage\":-4.76,\"sector\":\"Engineering and Construction\"},{\"name\":\"Larsen\",\"current\":1428,\"difference\":52,\"percentage\":3.51,\"sector\":\"Engineering and Construction\"},{\"name\":\"Siemens\",\"current\":1284,\"difference\":-24,\"percentage\":-1.9,\"sector\":\"Engineering and Construction\"},{\"name\":\"Asian Paints\",\"current\":1190,\"difference\":-20,\"percentage\":-1.71,\"sector\":\"Fast Moving Consumer Goods\"},{\"name\":\"Dabur\",\"current\":270,\"difference\":25,\"percentage\":8.47,\"sector\":\"Fast Moving Consumer Goods\"},{\"name\":\"Hind Liver\",\"current\":916,\"difference\":-6,\"percentage\":-0.66,\"sector\":\"Fast Moving Consumer Goods\"},{\"name\":\"ITC\",\"current\":240,\"difference\":20,\"percentage\":7.69,\"sector\":\"Fast Moving Consumer Goods\"},{\"name\":\"HCL Tech\",\"current\":739,\"difference\":51,\"percentage\":6.46,\"sector\":\"Information Technology\"},{\"name\":\"Infosys\",\"current\":1000,\"difference\":60,\"percentage\":5.66,\"sector\":\"Information Technology\"},{\"name\":\"TCS\",\"current\":2250,\"difference\":155,\"percentage\":6.44,\"sector\":\"Information Technology\"},{\"name\":\"Wipro\",\"current\":495,\"difference\":-15,\"percentage\":-3.13,\"sector\":\"Information Technology\"},{\"name\":\"GAIL\",\"current\":350,\"difference\":40,\"percentage\":10.26,\"sector\":\"Oil and Gas\"},{\"name\":\"HPCL\",\"current\":430,\"difference\":-25,\"percentage\":-6.17,\"sector\":\"Oil and Gas\"},{\"name\":\"ONGC\",\"current\":270,\"difference\":-15,\"percentage\":-5.88,\"sector\":\"Oil and Gas\"},{\"name\":\"Reliance\",\"current\":1075,\"difference\":5,\"percentage\":0.46,\"sector\":\"Oil and Gas\"},{\"name\":\"Cipla\",\"current\":630,\"difference\":-35,\"percentage\":-5.88,\"sector\":\"Pharma\"},{\"name\":\"Dr. Reddy\",\"current\":3193,\"difference\":-43,\"percentage\":-1.37,\"sector\":\"Pharma\"},{\"name\":\"Sun Pharma\",\"current\":850,\"difference\":-70,\"percentage\":-8.97,\"sector\":\"Pharma\"},{\"name\":\"Wockhardt\",\"current\":1000,\"difference\":-110,\"percentage\":-12.36,\"sector\":\"Pharma\"},{\"name\":\"Bharti Airtel\",\"current\":340,\"difference\":-15,\"percentage\":-4.62,\"sector\":\"Telecom\"},{\"name\":\"Idea\",\"current\":80,\"difference\":5,\"percentage\":5.88,\"sector\":\"Telecom\"},{\"name\":\"Reliance Communications\",\"current\":50,\"difference\":-1,\"percentage\":-2.04,\"sector\":\"Telecom\"}]}"
        // serialise the json response into StockItem array
        let apiCall: StocksListAPICall = StocksListAPICall(urlString: "https://infisesapitest-swghosh.rhcloud.com/api/stockslist", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC")
        stocks = apiCall.getStocksList(jsonData: jsonString.data(using: .utf8)!)
        
        time.text = apiCall.time!
        
        
        activity.stopAnimating()
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
//        if(indexPath.row % 5 == 0) {
//            cell = getSectorCell(tableView, index: indexPath.row)
//        }
//        else {
            cell = getStockCell(tableView, index: indexPath.row)
//        }
        return cell
        
    }
    
    func getSectorCell(_ tableView: UITableView, index: Int) -> SectorTableViewCell {
        let cellIdentifier = "Sector"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SectorTableViewCell
        
        cell.sectorName.text = stocks[index].sector
        
        return cell
    }
    
    func getStockCell(_ tableView: UITableView, index: Int) -> StockTableViewCell {
        let cellIdentifier = "Stock"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! StockTableViewCell
        
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the total number of rows in the table
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier = "FullStockFromHome"
        performSegue(withIdentifier: segueIdentifier, sender: stocks[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FullStockFromHome"  {
            let destinationViewController = segue.destination as! FullStockViewController
            destinationViewController.stock = sender as? StockItem
        }
    }

}

