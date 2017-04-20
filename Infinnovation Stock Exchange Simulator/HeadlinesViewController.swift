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
    @IBOutlet weak var headlinesTableView: UITableView!
    
    var news: [NewsItem] = [NewsItem]()
    
    func fetchAndSetup() {
        // serialise the json response into StockItem array
        let apiCall: HeadlinesListAPICall = HeadlinesListAPICall(urlString: "https://infisesapitest-swghosh.rhcloud.com/api/headlineslist", apiKey: "Z9FpluAnvXADniEcz9Rcvg28U1CdNC")
        if apiCall.performApiCall() != nil {
            news = apiCall.getHeadlinesList()
            
            time.text = apiCall.time!
            
        }
        else {
            displayNoInternet()
            return
        }
        headlinesTableView.reloadData()
    }
    
    func displayNoInternet() {
        let alertController = UIAlertController(title: "Network Issue", message: "No internet connection is currently available. Please make sure that you have a working internet connection in order to use this application.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay!", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchAndSetup()
        activity.stopAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // start animating the activity
        activity.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
