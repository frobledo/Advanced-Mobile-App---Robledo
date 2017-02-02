//
//  FourthViewController.swift
//  Music
//
//  Created by Fuji Robledo on 2/2/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    @IBAction func gotomusic(_ sender: UIButton) {
        
        //check to see if there's an app installed to handle this URL scheme
        //google to obtain url
        if(UIApplication.shared.canOpenURL(URL(string: "pandora://")!)){
            //open the app with this URL scheme
            UIApplication.shared.open(URL(string:"pandora://")!, options: [:], completionHandler: nil)
            print("pandora")
        } else{
            if(UIApplication.shared.canOpenURL(URL(string: "music://")!)){
                UIApplication.shared.open(URL(string: "music://")!, options: [:], completionHandler: nil)
                print("music")
            } else{
                UIApplication.shared.open(URL(string: "http://www.apple.con/music/")!, options: [:], completionHandler: nil)
                print("method appears to work")
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
