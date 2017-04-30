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
    
    var texts: [String: String] = [String: String]()
    
    func getTexts() -> [String: String] {
        do {
            let fileUrl = Bundle.main.url(forResource: "About", withExtension: "plist")
            let data = try Data(contentsOf: fileUrl!)
            
            texts = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.ReadOptions(), format: nil) as! [String: String]
        }
        catch {
            print(error)
        }
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
        _ = getTexts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Info"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentfier = "Basic"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentfier)!
        cell.textLabel?.text = texts[texts.index(texts.startIndex, offsetBy: indexPath.row)].key
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier = "InformationFromAbout"
        let content: (String, String) = (texts[texts.index(texts.startIndex, offsetBy: indexPath.row)].key, texts[texts.index(texts.startIndex, offsetBy: indexPath.row)].value)
        performSegue(withIdentifier: segueIdentifier, sender: content)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "InformationFromAbout" {
            let destinationViewController = segue.destination as! InformationViewController
            let content = sender as! (String, String)
            destinationViewController.name = content.0
            destinationViewController.info = content.1
        }
    }
    

}
