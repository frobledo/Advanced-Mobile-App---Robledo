//
//  MainTableViewController.swift
//  Star Wars
//
//  Created by Fuji Robledo on 3/23/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var objects = [[String : String]]()
    
    func loadjson() {
        let urlPath = "http://swapi.co/api/people/"
        
        guard let url = URL(string: urlPath)
            else{
                print("URL error")
                return
        }
        
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            guard statusCode == 200
                else{
                    print("File download error")
                    return
            }
            
            print("Download complete")
            DispatchQueue.main.async {self.parsejson(data!)}
        })
            
            session.resume()
    }
    
    func parsejson(_ data: Data){
        do{
            
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            
            let allresults = json["results"] as! [[String : Any]]
            
            for result in allresults {
                guard let name = result["name"]! as? String,
                let height = result["height"]! as? String
                    else{
                        continue
                }
                let obj = ["name": name, "height": height]
                self.objects.append(obj)
            }
        } catch{
                print("Error with JSON: \(error)")
                return
            }
            tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadjson()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return objects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object["name"]
        cell.detailTextLabel!.text = object["height"]! + " centimeters"
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
