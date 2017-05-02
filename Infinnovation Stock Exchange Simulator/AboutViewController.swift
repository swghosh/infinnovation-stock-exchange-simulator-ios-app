//
//  AboutViewController.swift
//  Infinnovation Stock Exchange Simulator
//
//  Created by SwG Ghosh on 03/04/17.
//  Copyright © 2017 infinnovation. All rights reserved.
//

import UIKit
import Foundation

class AboutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // stores a dictionary based on data fetched from About.plist
    var texts: [String: String] = [String: String]()
    
    func getTexts() -> [String: String] {
        do {
            // the file URL of About.plist
            let fileUrl = Bundle.main.url(forResource: "About", withExtension: "plist")
            // the data present inside the plist file
            let data = try Data(contentsOf: fileUrl!)
            
            // the data is serialised to required format
            texts = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.ReadOptions(), format: nil) as! [String: String]
        }
        catch {
            print(error)
        }
        // the appropriate dictionary is returned
        return texts
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // disables the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // used to fetch the data from plist and parse it into required format
        _ = getTexts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // conforms to the UITableViewDataSource protocol
        
        // returns that the table have a single section
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // conforms to the UITableViewDataSource protocol
        
        // returns the only section in the table have specified header
        return "Info"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // conforms to the UITableViewDataSource protocol
        
        // returns the number of rows
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // conforms to the UITableViewDataSource protocol
        
        let cellIdentfier = "Basic"
        // obtain a protototype cell specified in IB
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentfier)!
        // sets the appropriate labels with the appropriate data for the current cell
        cell.textLabel?.text = texts[texts.index(texts.startIndex, offsetBy: indexPath.row)].key
        
        // returns the required cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // conforms to UITableViewDataSource protocol

        let segueIdentifier = "InformationFromAbout"
        // the content that is to be passed as segue sender
        let content: (String, String) = (texts[texts.index(texts.startIndex, offsetBy: indexPath.row)].key, texts[texts.index(texts.startIndex, offsetBy: indexPath.row)].value)
        // performs a segue when table cell is selected
        performSegue(withIdentifier: segueIdentifier, sender: content)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare for a segue to be performed
        if segue.identifier == "InformationFromAbout" {
            // the destination view controller for the segue is obtained
            let destinationViewController = segue.destination as! InformationViewController
            // the destination view controller's stock value is set to two required strings received from the sender
            let content = sender as! (String, String)
            destinationViewController.name = content.0
            destinationViewController.info = content.1
        }
    }
    

}
