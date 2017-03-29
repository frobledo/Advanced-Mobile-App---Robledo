//
//  MainTableViewController.swift
//  My Books
//
//  Created by Fuji Robledo on 3/24/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit
import Firebase

class MainTableViewController: UITableViewController {
    
    var ref : FIRDatabaseReference!
    var myBooks = [Books]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        ref.observe(FIRDataEventType.value, with: {snapshot in self.myBooks = []
            for item in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let newBook = Books(snapshot: item)
                self.myBooks.append(newBook)
            }
            self.tableView.reloadData()
        })

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
        return myBooks.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let book = myBooks[indexPath.row]
        cell.textLabel!.text = book.bookName
        cell.detailTextLabel!.text = book.author
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
            let book = myBooks[indexPath.row]
            let bookref = ref.child(book.bookName)
            bookref.ref.removeValue()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
           
        }    
    }

    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        
        if segue.identifier == "saveSegue" {
            let source = segue.source as! AddViewController
            if source.addedBook.isEmpty == false {
                let myNewBook = Books(newname: source.addedBook, newauthor: source.addedAuthor)
                let myNewBookDict = ["name": source.addedBook, "author": source.addedAuthor]
                let bookref = ref.child(source.addedBook)
                bookref.setValue(myNewBookDict)
            }
        }
        
    }
 

}
