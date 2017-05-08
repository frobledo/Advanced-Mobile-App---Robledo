//
//  AddDietViewController.swift
//  myhealthypup
//
//  Created by Fuji Robledo on 5/1/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class AddDietViewController: UIViewController {
    
    var diet : Diet?
    
    @IBOutlet weak var typePicked: UISegmentedControl!
    @IBOutlet weak var datePicked: UIDatePicker!
    var selectedDate = ""
    var selectedType = ""

    @IBAction func datePicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy h:mm a"
        selectedDate = dateFormatter.string(from: datePicked.date)
        print(selectedDate)
    }
    
    @IBAction func typeSegmentedAction(_ sender: Any) {
        if(typePicked.selectedSegmentIndex == 0){
            selectedType = "Treat"
        }
        if(typePicked.selectedSegmentIndex == 1){
            selectedType = "Meal"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if selectedDate.isEmpty{
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy h:mm a"
            selectedDate = dateFormatter.string(from: currentDate)
        }
        
        if selectedType.isEmpty{
            selectedType = "None"
        }
        
        let date = selectedDate
        let type = selectedType
        
        if segue.identifier == "saveFoodSegue"{
            super.prepare(for: segue, sender: sender)
            diet = Diet(date: date, type: type)
        }

    }
}
