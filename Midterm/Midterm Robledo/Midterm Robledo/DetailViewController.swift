//
//  DetailViewController.swift
//  Midterm Robledo
//
//  Created by Fuji Robledo on 3/16/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var mySkiRunsDetail = SkiRuns()
    var searchController : UISearchController!
    
    var mySkiPlaces = [String]()
    var selectedSkiPlace = 0
    
    override func viewWillAppear(_ animated: Bool) {
        
        mySkiRunsDetail.skiPlace = Array(mySkiRunsDetail.skiRunData.keys)
        
        let chosenSkiPlace = mySkiRunsDetail.skiPlace[selectedSkiPlace]
        mySkiPlaces = mySkiRunsDetail.skiRunData[chosenSkiPlace]! as [String]
        
        let resultsController = SearchResultsController()
        resultsController.allwords = mySkiPlaces
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchBar.placeholder = "Enter a search term"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView=searchController.searchBar
        searchController.searchResultsUpdater = resultsController
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mySkiPlaces.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)

        cell.textLabel?.text = mySkiPlaces[indexPath.row]

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            mySkiPlaces.remove(at: indexPath.row)
            let chosenSkiPlace = mySkiRunsDetail.skiPlace[selectedSkiPlace]
            mySkiRunsDetail.skiRunData[chosenSkiPlace]?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == "doneSegue" {
            
            let source = segue.source as! AddSkiRunViewController
            
            if((source.addedSkiRun.isEmpty) == false){
                mySkiPlaces.append(source.addedSkiRun)
                tableView.reloadData()
                let chosenPlace = mySkiRunsDetail.skiPlace[selectedSkiPlace]
                mySkiRunsDetail.skiRunData[chosenPlace]?.append(source.addedSkiRun)
            }
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
