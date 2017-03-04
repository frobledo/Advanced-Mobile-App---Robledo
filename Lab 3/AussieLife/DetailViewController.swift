//
//  DetailViewController.swift
//  AussieLife
//
//  Created by Fuji Robledo on 3/3/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailView: UIImageView!
    
    var imageName : String?
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let name = imageName {
            
            detailView.image = UIImage(named: name)
        }
    }
    

    @IBAction func share(_ sender: UIBarButtonItem) {
        
        var imageArray = [UIImage]()
        imageArray.append(detailView.image!)
        let shareScreen = UIActivityViewController(activityItems: imageArray, applicationActivities: nil)
        shareScreen.modalPresentationStyle = .popover
        shareScreen.popoverPresentationController?.barButtonItem = sender as UIBarButtonItem
        present(shareScreen, animated: true, completion: nil)
        
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
