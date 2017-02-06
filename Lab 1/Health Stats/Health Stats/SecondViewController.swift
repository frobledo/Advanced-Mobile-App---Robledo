//
//  SecondViewController.swift
//  Health Stats
//
//  Created by Fuji Robledo on 1/26/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var exercisePicker: UIPickerView!
    @IBOutlet weak var exerciseLabel: UILabel!
    
    let exercise = ["cardio", "stretching", "strength", "variety"]
    let time = ["20 minutes", "30 minutes", "45 minutes", "60 minutes"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return exercise.count
        } else{
            return time.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return exercise[row]
        } else {
            return time[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let exerciseRow = pickerView.selectedRow(inComponent: 0)
        let timeRow = pickerView.selectedRow(inComponent: 1)
        
        exerciseLabel.text = "\(exercise[exerciseRow]) for \(time[timeRow])"
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

