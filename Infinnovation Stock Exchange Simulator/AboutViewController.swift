//
//  AboutViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 03/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var rowTexts: [String] = ["Rules and Regulations", "Disclaimer", "License"]
    var infoTexts: [String] = ["We are presenting before you a very unique simulation game this year at Infinnovation’16. \"Infi-Invest\"\n\nNo. of participants: 2 per school\n\nIt is a simulation game wherein, the representatives invest virtual money given to them in listed shares.\n\nThe panel consists of students of the host school.\n\nThe timings would be 9:30-11:30 AM. (offstage)\n\nThe updates will be given at 12:30 PM on stage. Few updates will also be given during the offstage session.\n\nThe transactions will be based on Day Trading.\n\nAll the participants will be accompanied by a broker (host school) who will record the transactions and bring it to the notice of the panel. Simultaneous update of the profile will be done.\n\nThe investment can only be done on the 40-50 selected listed diversified stocks of BSE and NSE.\n\nThe back stage event will be followed by the on stage session. The school with maximum profit after the updates(onstage) provided, wins the competition.\n\nINR 10, 00,000 will be given as the virtual capital.\n\nCredit facility will be provided @6% on the principal value.\n\nTrade commission fees will be charged @INR 10 per transaction.\n\nThe regulation and speculation of stock prices will be done through this app.(It represents simulated stock exchange and does not reflect the values of a real stock market).\n\nThe prices of the securities invested in will be provided in the app itself.\n\nThe prices of the securities will be based on the general trend of the company.\n\nThe fluctuations on the event day will be regulated by the panel with respect to an imaginary economic situation.\n\nThe participants must have a minimum of 75% of their account balances invested in securities before the onstage event begins.\n\nThe updates provided on stage will affect the prices of the stocks held by the participants. The updates will be provided by the panel sector wise, after which the school with the highest portfolio wins.", "The information contained on this app/website is for general information purposes only.\n\nWe make no representations or warranties of any kind, express or implied, about the completeness, accuracy, reliability, suitability or availability with respect to the app/website or the information, products, services, or related graphics contained on the app/website for any purpose.\n\nAny reliance you place on such information is therefore strictly at your own risk.\n\nThe general trend available on the app/website is for event (Infi-Invest) purposes only and has no intentions of manipulating the company policies and the stock prices.\n\nThe Stock Prices will be a hypothetical representation of the actual values. It has no links with the actual stock prices and company policies.\n\nInfinnovation Stock Exchange Simulator is not responsible for any errors, omissions or representations on any of our pages or on any links on any of our pages. Infinnovation Stock Exchange Simulator does not endorse in anyway any advertisers on our web pages. Please verify the veracity of all information on your own before undertaking any alliance.", "This app is based on an open-source project hosted on GitHub. (https://github.com/swghosh/infinnovation-stock-exchange-simulator-ios-app)\n\nMIT License\n\nCopyright (c) 2016-17 Swarup Ghosh & Delhi Public School Newtown.\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // disables the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowTexts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentfier = "Basic"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentfier)!
        cell.textLabel?.text = rowTexts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier = "InformationFromAbout"
        let content: [String] = [rowTexts[indexPath.row], infoTexts[indexPath.row]]
        performSegue(withIdentifier: segueIdentifier, sender: content)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "InformationFromAbout" {
            let destinationViewController = segue.destination as! InformationViewController
            let content = sender as! [String]
            destinationViewController.name = content[0]
            destinationViewController.info = content[1]
        }
    }
    

}
