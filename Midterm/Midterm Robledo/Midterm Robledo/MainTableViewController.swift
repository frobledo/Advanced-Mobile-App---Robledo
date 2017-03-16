//
//  MainTableViewController.swift
//  Midterm Robledo
//
//  Created by Fuji Robledo on 3/16/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var mySkiRuns = SkiRuns()
    let kfilename = "data.plist"
    
    func docFilePath(_ filename: String) -> String? {
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString
        return dir.appendingPathComponent(filename)
        
    }
    
    func getDataFile() -> String? {
        
        guard let pathString = Bundle.main.path(forResource: "SkiResorts", ofType: "plist") else{
            return nil
        }
        return pathString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path: String?
        let filePath = docFilePath(kfilename)
        
        if FileManager.default.fileExists(atPath: filePath!){
            path = filePath
        } else{
            path = getDataFile()
        }

        mySkiRuns.skiRunData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        mySkiRuns.skiPlace = Array(mySkiRuns.skiRunData.keys)
        
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
        
    }
    
    func applicationWillResignActive(_ notification: Notification){
        
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        data.addEntries(from: mySkiRuns.skiRunData)
        data.write(toFile: filePath!, atomically: true)
        
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
        return mySkiRuns.skiRunData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)

        cell.textLabel?.text = mySkiRuns.skiPlace[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            
            let detailVC = segue.destination as! DetailViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            
            detailVC.title = mySkiRuns.skiPlace[indexPath.row]
            detailVC.mySkiRunsDetail = mySkiRuns
            detailVC.selectedSkiPlace = indexPath.row
            
        }
        
    }
    

}
