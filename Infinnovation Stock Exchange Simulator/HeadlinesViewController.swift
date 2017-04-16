//
//  HeadlinesViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 02/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class HeadlinesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var news: [NewsItem] = [NewsItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // json response
        let jsonString: String = "{\"time\":\"16/04/2017 19:58:21\",\"result\":[{\"time\":\"05/10/16 16:00\",\"content\":\"Infinnovation Stock Exchange is now closed.\"},{\"time\":\"05/10/16 12:22\",\"content\":\"InterGlobe Aviation purchased a fleet of 600 aircrafts at the London Yearly Summit of the Pilot\'s Association. The company\'s assets have swelled tremendously and the share prices have shown a 5% progress.\"},{\"time\":\"05/10/16 12:20\",\"content\":\"Cement shares rise by 2-5% after the tax implementation went down from 25% to 20%. ACC Cements hit the 10% surge mark after 6 months after the Finance Minister announced the execution of the bill.\"},{\"time\":\"05/10/16 12:11\",\"content\":\"Siemens Annual General Meeting Resolutions: The company made tremendous profits in the AY and therefore announced free shares to its shareholders @50 shares per 200 shares held.\"},{\"time\":\"05/10/16 12:00\",\"content\":\"State-owned ONGC and GAIL are making losses on natural gas production after government cut rates for the fourth consecutive time to bring down selling price to below the cost of production. \"},{\"time\":\"05/10/16 11:42\",\"content\":\"Maruti Suzuki received a Block deal of 200 SUVs by a new Taxi company. The company might see violent fluctuations in the prices of the shares. \"},{\"time\":\"05/10/16 11:38\",\"content\":\"Current Economic Situation\\r\\nName of the SectorValueChange\\r\\nAutomobile22457.00-38.00\\r\\nBanking and Finance23344.00-68.00\\r\\nHealthcare16531.00+156.00\\r\\nIT10384.00+82.00\\r\\nFMCG9036.00+350.00\\r\\nAviation15486.00-16.00\\r\\nEngineering &amp; Construction14994.00+5.00\\r\\nTelecoms5640.00-52.00\\r\\nCement7526.00-86.00\\r\\nOil &amp; Gas11369.00+80.00\"},{\"time\":\"05/10/16 11:10\",\"content\":\"LIC Housing Premium declined 2per cent  after the board approved the issue of bonus shares to its shareholders. The shares are to be issued as 10 shares to every 15 shares held.\"},{\"time\":\"05/10/16 11:00\",\"content\":\"Board Meeting Resolution : Cipla Limited offered its shareholders to buy the equity shares at the nominal value after the company made tremendous profits in the interim sessions. The profits were swelled by 12% as compared to its competitors.\"},{\"time\":\"05/10/16 10:44\",\"content\":\"State Bank of India the country\'s largest lender, raised $300 million by selling perpetual bonds overseas, falling short of target as investors sought higher interest rates. The offshore perpetual bonds - the first to be issued by an Indian bank - are aimed at shoring up SBI\'s capital base and bolstering its loss-absorption capacity . The company announced a 10% interim dividend to its shareholder on the current price of the stocks.\"},{\"time\":\"05/10/16 10:31\",\"content\":\"Over the last six months, the government has put a lot of building blocks in place for a broad-based growth and focus will now be on implementation of these policies says Rakesh Jhunjhunwala, the most successful Indian Stock Exchange tycoon. \"},{\"time\":\"05/10/16 10:21\",\"content\":\"Leading Indian telecoms including Bharti Airtel Vodafone India, Idea Cellular  and newcomer Reliance Jio Infocomm set the ball rolling on day one of India\'s largest ever spectrum sale. The Spectrum was acquired was Bharti Airtel and Aircel jointly which was a huge blow to their newest competitor Reliance Jio Infocomm. \"},{\"time\":\"05/10/16 10:14\",\"content\":\"Sector wise current economic situation\\r\\nAutomobile22457.00-38.00\\r\\nBanking and Finance23487.00+75.00\\r\\nHealthcare16531.00+156.00\\r\\nIT10384.00+82.00\\r\\nFMCG8836.00+150.00\\r\\nAviation15486.00-16.00\\r\\nEngineering &amp; Construction15034.00+45.00\\r\\nTelecoms5640.00-52.00\\r\\nCement7526.00-86.00\\r\\nOil &amp; Gas11169.00-80.00\"},{\"time\":\"05/10/16 10:10\",\"content\":\"We\'ll be providing you updates on the prices of the securities/stocks from this app itself. Also, you can view a detail of any stock or sector by clicking on the stock name from the stocks overview page.\"},{\"time\":\"05/10/16 10:00\",\"content\":\"Infinnovation Stock Exchange is now open.\"}]}"
        // serialise the json response into StockItem array
        let apiCall: HeadlinesListAPICall = HeadlinesListAPICall(urlString: "https://infisesapitest-swghosh.rhcloud.com/api/headlineslist", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC")
        news = apiCall.getHeadlinesList(jsonData: jsonString.data(using: .utf8)!)
        
        time.text = apiCall.time!
        activity.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 70.0
        let height = UITableViewAutomaticDimension
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "News"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! NewsTableViewCell
        cell.time.text = news[indexPath.row].time
        cell.news.text = news[indexPath.row].content
        return cell
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
