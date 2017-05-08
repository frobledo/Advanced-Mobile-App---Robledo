//
//  HealthTableViewController.swift
//  myhealthypup
//
//  Created by Fuji Robledo on 5/1/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit
import os.log

class HealthTableViewController: UITableViewController {
    
    var healthInfo = [Health]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedHealth = loadHealth(){
            healthInfo += savedHealth }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healthInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let health = healthInfo[indexPath.row]
        
        cell.textLabel?.text = health.date
        cell.detailTextLabel?.text = health.type
        
        switch(health.type){
        case("Sick Visit"):
            cell.imageView?.image=UIImage(named:"sick.png")
            break
        case("Annual Visit"):
            cell.imageView?.image=UIImage(named:"annual.png")
            break
        case("Vaccine"):
            cell.imageView?.image=UIImage(named:"vaccine.png")
            break
        case("Grooming"):
            cell.imageView?.image=UIImage(named:"grooming.png")
            break
        default:
            break
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            healthInfo.remove(at: indexPath.row)
            saveHealth()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }
 
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        if segue.identifier == "saveHealthSegue"{
            let segueSource = segue.source as! AddHealthViewController
            let health = segueSource.health
            healthInfo.insert(health!, at: 0)
            saveHealth()
            
            tableView.reloadData()
            
        }
    }
    
    private func saveHealth(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(healthInfo, toFile: Health.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Health data successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Health data failed to save.", log: OSLog.default, type: .error)
        }
    }
    
    private func loadHealth() -> [Health]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Health.ArchiveURL.path) as? [Health]
    }
}
