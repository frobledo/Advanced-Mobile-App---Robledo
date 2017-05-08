//
//  AddHealthViewController.swift
//  myhealthypup
//
//  Created by Fuji Robledo on 5/1/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class AddHealthViewController: UIViewController {
    
    var health : Health?
    
    @IBOutlet weak var dateTimePicked: UIDatePicker!
    @IBOutlet weak var typeSelection: UISegmentedControl!
    @IBOutlet weak var moodSelection: UISegmentedControl!
    
    var selectedDate = ""
    var selectedType = ""

    @IBAction func datePicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy h:mm a"
        selectedDate = dateFormatter.string(from: dateTimePicked.date)
        print(selectedDate)
    }
    
    @IBAction func typeSegmentedControl(_ sender: Any) {
        if(typeSelection.selectedSegmentIndex == 0){
            selectedType = "Sick Visit"
        }
        if(typeSelection.selectedSegmentIndex == 1){
            selectedType = "Annual Visit"
        }
        if(typeSelection.selectedSegmentIndex == 2){
            selectedType = "Vaccine"
        }
        if(typeSelection.selectedSegmentIndex == 3){
            selectedType = "Grooming"
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
        
        if segue.identifier == "saveHealthSegue"{
            super.prepare(for: segue, sender: sender)
            health = Health(date: date, type: type)
        }
    }

}
