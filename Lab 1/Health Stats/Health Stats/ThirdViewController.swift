//
//  ThirdViewController.swift
//  Health Stats
//
//  Created by Fuji Robledo on 2/3/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var foodPicker: UIPickerView!
    @IBOutlet weak var foodLabel: UILabel!
    
    let mealtimeComponent = 0
    let foodtypeComponent = 1
    
    var food = [String: [String]]()
    var mealtime = [String]()
    var foodtype = [String]()
    
    func getDataFile() -> String? {
        guard let pathString = Bundle.main.path(forResource: "foodOptions", ofType: "plist") else{
            return nil
        }
        return pathString
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == mealtimeComponent {
            return mealtime.count
        } else{
            return foodtype.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == mealtimeComponent {
            return mealtime[row]
        } else {
            return foodtype[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == mealtimeComponent {
            let selectedMealtime = mealtime[row]
            foodtype = food[selectedMealtime]!
            
            foodPicker.reloadComponent(foodtypeComponent)
            foodPicker.selectRow(0, inComponent: foodtypeComponent, animated: true)
        }
        
        let mealtimeRow = pickerView.selectedRow(inComponent: mealtimeComponent)
        let foodtypeRow = pickerView.selectedRow(inComponent: foodtypeComponent)
        
        
        foodLabel.text = "At \(mealtime[mealtimeRow]), you ate \(foodtype[foodtypeRow])"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let path = getDataFile()
            else{
                print("Error")
                return
            }
        
        food = NSDictionary(contentsOfFile: path) as! [String: [String]]
        mealtime = Array(food.keys)
        foodtype = food[mealtime[0]]! as [String]
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
