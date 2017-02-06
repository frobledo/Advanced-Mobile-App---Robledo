//
//  FourthViewController.swift
//  Health Stats
//
//  Created by Fuji Robledo on 2/3/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    @IBAction func healthAppButton(_ sender: UIButton) {
        if(UIApplication.shared.canOpenURL(URL(string: "activity://")!)) {
            UIApplication.shared.open(URL(string: "activity://")!, options: [:], completionHandler: nil)
        }
        if(UIApplication.shared.canOpenURL(URL(string: "health://")!)) {
            UIApplication.shared.open(URL(string: "health://")!, options: [:], completionHandler: nil)
        }
        if(UIApplication.shared.canOpenURL(URL(string: "http://www.apple.com/health")!)) {
            UIApplication.shared.open(URL(string: "http://www.apple.com/health")!, options: [:], completionHandler: nil)
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
