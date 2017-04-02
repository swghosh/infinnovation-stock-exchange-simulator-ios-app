//
//  HeadlinesViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 02/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class HeadlinesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activity.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "News"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! NewsTableViewCell
        cell.time.text = "18/02/17 09:43"
        cell.news.text = "Cement shares rise by 2-5% after the tax implementation went down from 25% to 20%. ACC Cements hit the 10% surge mark after 6 months after the Finance Minister announced the execution of the bill."
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
