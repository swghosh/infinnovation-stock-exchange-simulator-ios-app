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
        
        // serialise the json response into StockItem array
        let apiCall: HeadlinesListAPICall = HeadlinesListAPICall(urlString: "https://infisesapitest-swghosh.rhcloud.com/api/headlineslist", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC")
        if apiCall.performApiCall() != nil {
            news = apiCall.getHeadlinesList()
            
            time.text = apiCall.time!
            
            activity.stopAnimating()
        }
        
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
