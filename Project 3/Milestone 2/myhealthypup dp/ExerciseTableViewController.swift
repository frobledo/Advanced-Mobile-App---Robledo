//
//  ExerciseTableViewController.swift
//  myhealthypup

//  Data persistance:
//  https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/PersistData.html#//apple_ref/doc/uid/TP40015214-CH14-SW1

//  Created by Fuji Robledo on 4/28/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit
import os.log

class ExerciseTableViewController: UITableViewController {
    
    var exerciseInfo = [Exercise]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedExercise = loadExercise(){
            exerciseInfo += savedExercise }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let exercise = exerciseInfo[indexPath.row]
        
        cell.textLabel?.text = exercise.date
        cell.detailTextLabel?.text = exercise.duration
        
        switch(exercise.mood){
        case("Happy"):
            cell.imageView?.image=UIImage(named:"happy.png")
            break
        case("Anxious"):
            cell.imageView?.image=UIImage(named:"anxious.png")
            break
        case("Upset"):
            cell.imageView?.image=UIImage(named:"upset.png")
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
            exerciseInfo.remove(at: indexPath.row)
            saveExercise()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    

   @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
    
    if segue.identifier == "saveSegue"{
        let segueSource = segue.source as! AddExerciseMController
        let exercise = segueSource.exercise
        exerciseInfo.insert(exercise!, at: 0)
        
        tableView.reloadData()
        saveExercise()
    }
  }
    
    private func saveExercise(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(exerciseInfo, toFile: Exercise.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Exercise data successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Exercise data failed to save.", log: OSLog.default, type: .error)
        }
    }
    
    private func loadExercise() -> [Exercise]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Exercise.ArchiveURL.path) as? [Exercise]
    }
    
}
