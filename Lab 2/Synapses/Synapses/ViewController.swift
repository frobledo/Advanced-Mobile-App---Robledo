//
//  ViewController.swift
//  Synapses
//
//  Created by Fuji Robledo on 2/18/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var mySynapse = SynapticStrength()
    let kfilename = "NewMechanism.plist"

    func docFilePath(_ filename: String) -> String? {
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString
        return dir.appendingPathComponent(filename)
        
    }
    
    func getDataFile() -> String? {
        
        guard let pathString = Bundle.main.path(forResource: "SynapticTraces", ofType: "plist")
            else {
                return nil
        }
        
        return pathString
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return mySynapse.stageData.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = mySynapse.mechanism[indexPath.row]
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path: String?
        let filePath = docFilePath(kfilename)
        
        if FileManager.default.fileExists(atPath: filePath!){
            path = filePath
        }
        else{
            path = getDataFile()
        }
       
        
        mySynapse.stageData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        mySynapse.mechanism = Array(mySynapse.stageData.keys)
        
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
    }
    
    func applicationWillResignActive(_ notification: Notification){
        
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        data.addEntries(from: mySynapse.stageData)
        data.write(toFile: filePath!, atomically: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mechanismsegue" {
            let detailVC = segue.destination as! MechanismTableViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            
            detailVC.title = mySynapse.mechanism[indexPath.row]
            detailVC.mySynapseDetail = mySynapse
            detailVC.selectedMechanism = indexPath.row
        }
    }


}

