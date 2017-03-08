//
//  MasterViewController.swift
//  TennisPro
//
//  Created by Fuji Robledo on 3/7/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var strokes = [[String : String]]()
    
    func getDataFile() -> String? {
        guard let pathString = Bundle.main.path(forResource: "tennisStrokes", ofType: "plist")
        else {
            return nil
        }
        return pathString
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        guard let path = getDataFile()
            else{
                print("Oops! Error loading file!")
                return
        }
        
        let alldata = NSDictionary(contentsOfFile: path) as! [String: [[String : String]]]
        
        if alldata.isEmpty != true {
            strokes = Array(alldata["strokes"]!)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let stroke = strokes[indexPath.row]
                let myURL = stroke["url"]! as String
                let strokeName = stroke["name"]! as String
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = myURL 
                controller.title = strokeName
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strokes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let strokeName = strokes[indexPath.row]
        cell.textLabel!.text = strokeName["name"]! as String
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    


}

