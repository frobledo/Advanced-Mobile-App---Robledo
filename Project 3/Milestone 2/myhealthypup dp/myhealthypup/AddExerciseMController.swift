//
//  AddExerciseMController.swift
//  myhealthypup
//
//  Created by Fuji Robledo on 4/30/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class AddExerciseMController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var exercise : Exercise?
   
    let duration = ["10 minutes", "15 minutes", "30 minutes", "45 minutes", "1 hour", "> 1 hour"]
    
    @IBOutlet weak var moodSelection: UISegmentedControl!
    @IBOutlet weak var datePickerSelection: UIDatePicker!
    
    var selectedDuration = ""
    var selectedDate = ""
    var selectedMood = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Code to obtain date from date picker: http://stackoverflow.com/questions/29502186/get-just-the-date-no-time-from-uidatepicker
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy h:mm a"
        selectedDate = dateFormatter.string(from: datePickerSelection.date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return duration.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return duration[row]
    }
    
    //To set duration for walk 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDuration = duration[row]
    }
    
    //To obtain what user selected as mood
    @IBAction func actionSegmentedControl(_ sender: Any) {
        if(moodSelection.selectedSegmentIndex == 0){
            selectedMood = "Happy"
        }
        if(moodSelection.selectedSegmentIndex == 1){
            selectedMood = "Anxious"
        }
        if(moodSelection.selectedSegmentIndex == 2){
            selectedMood = "Upset"
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if selectedDate.isEmpty{
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy h:mm a"
            selectedDate = dateFormatter.string(from: currentDate)
        }
        
        if selectedDuration.isEmpty{
            selectedDuration = "10 minutes"
        }
        
        if selectedMood.isEmpty{
            selectedMood = "Happy"
        }
        
        let date = selectedDate
        let duration = selectedDuration
        let mood = selectedMood
        
        if segue.identifier == "saveSegue"{
            super.prepare(for: segue, sender: sender)
            exercise = Exercise(date: date, duration: duration, mood: mood)
        }

        
    }


}
