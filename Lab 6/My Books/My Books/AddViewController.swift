//
//  AddViewController.swift
//  My Books
//
//  Created by Fuji Robledo on 3/24/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var addBook: UITextField!
    @IBOutlet weak var addAuthor: UITextField!
    
    var addedBook = String()
    var addedAuthor = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "saveSegue" {
            if addBook.text?.isEmpty == false {
                addedBook = addBook.text!
                addedAuthor = addAuthor.text!
            }
        }
    }

}
