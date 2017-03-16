//
//  AddSkiRunViewController.swift
//  Midterm Robledo
//
//  Created by Fuji Robledo on 3/16/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class AddSkiRunViewController: UIViewController {

    @IBOutlet weak var skiRunTextfield: UITextField!
    
    var addedSkiRun = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "doneSegue"{
            
            if((skiRunTextfield.text?.isEmpty) == false) {
                addedSkiRun = skiRunTextfield.text!
            }
        }
    }

}
