//
//  ViewController.swift
//  D&P Milestone 2
//
//  Created by Fuji Robledo on 2/24/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userName: String?
    var penguin : Int?
    var mode : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        
        if segue.identifier == "saveSegue" {
          
        }
    }
    
}

