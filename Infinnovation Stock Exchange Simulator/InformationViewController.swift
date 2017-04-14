//
//  InformationViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 13/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    var name: String?
    var info: String?
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var content: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // enable the navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        heading.text = name
        content.text = info
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
