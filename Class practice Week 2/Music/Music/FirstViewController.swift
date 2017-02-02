//
//  FirstViewController.swift
//  Music
//
//  Created by Fuji Robledo on 1/24/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var musicPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    //simple array
    let genre = ["Country", "Pop", "Rock", "Classical", "Alternative", "Hip Hop", "Jazz"]
    
    //methods to implement picker
    //required for the UIPickerViewDataSource protocol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //returns how many components
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //needs how many rows are in this component
        return genre.count
    }
    
    //return title for the row
    //if you do not want external parameter name - use _ (takes in a pickerView and an int for the row and component; returns a string - what you want to put in the row)
    //method called for every row in the picker 
    //data is loaded - only loads the data that you need at that point - cannot see picker options that are not needed
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //row is a parameter of type int; genre is the array
        return genre[row]
    }
    
    //what happens when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choiceLabel.text="You like \(genre[row])" //writes the string with the row's content to the label 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

