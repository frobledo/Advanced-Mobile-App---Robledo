//
//  DietTableViewController.swift
//  myhealthypup
//
//  Created by Fuji Robledo on 5/1/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit
import os.log

class DietTableViewController: UITableViewController {
    
    var dietInfo = [Diet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedDiet = loadDiet(){
            dietInfo += savedDiet }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dietInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let diet = dietInfo[indexPath.row]
        
        cell.textLabel?.text = diet.date
        cell.detailTextLabel?.text = diet.type
        
        switch(diet.type){
        case("Treat"):
            cell.imageView?.image=UIImage(named:"bone.png")
            break
        case("Meal"):
            cell.imageView?.image=UIImage(named:"bowl.png")
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
            dietInfo.remove(at: indexPath.row)
            saveDiet()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {

        }    
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        if segue.identifier == "saveFoodSegue"{
            let segueSource = segue.source as! AddDietViewController
            let diet = segueSource.diet
            dietInfo.insert(diet!, at: 0)
            saveDiet()
            
            tableView.reloadData()
        }
    }
    
    private func saveDiet(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(dietInfo, toFile: Diet.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Diet data successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Diet data failed to save.", log: OSLog.default, type: .error)
        }
    }
    
    private func loadDiet() -> [Diet]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Diet.ArchiveURL.path) as? [Diet]
    }


}
