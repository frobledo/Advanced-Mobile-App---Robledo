//
//  AddMechanismViewController.swift
//  Synapses
//
//  Created by Fuji Robledo on 2/18/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class AddMechanismViewController: UIViewController {

    @IBOutlet weak var mechanismText: UITextField!
    
    var addedMechanism = String()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "doneSegue" {
            if ((mechanismText.text?.isEmpty) == false){
            addedMechanism = mechanismText.text!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
