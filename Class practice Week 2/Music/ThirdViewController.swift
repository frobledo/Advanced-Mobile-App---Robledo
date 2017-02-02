//
//  ThirdViewController.swift
//  Music
//
//  Created by Fuji Robledo on 1/31/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var artistPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    //arrays are good to use for small data
    //plists: property lists
    
    //optional; can use the number if you want - may not be as clear
    let artistComponent = 0
    let albumComponent = 1
    
    //instead of making it an optional - initialize as empty (not the same as not having a value)
    var artistAlbums = [String: [String]]()
    var artists = [String]()
    var albums = [String]()
    
    //get data out of plist and return an optional string - get path to where the plist is so that the data can be used
    //bundle class has a method for path - provide name and type; needs to match exactly the name of the file
    //handle what happens if app crashes - use a guard statement with a let: optionally unwrapping the path
    //if it cannot find it, it will return nill
    func getDataFile() -> String? {
        guard let pathString = Bundle.main.path(forResource: "artistalbums", ofType: "plist")
            else{
                return nil
        }
        print("getting data")
        return pathString
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        print("number of components")
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        print("number of rows in component")
        
        if component == artistComponent {
            return artists.count
        
        } else {
            return albums.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("title for row method")
        if component == artistComponent{
            return artists[row]
        } else {
            return albums[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("picker view component")
        if component == artistComponent{
            let selectedArtist = artists[row]
            albums = artistAlbums[selectedArtist]!
            artistPicker.reloadComponent(albumComponent)
            artistPicker.selectRow(0, inComponent: albumComponent, animated: true)
        }
        
        let artistrow = pickerView.selectedRow(inComponent: artistComponent)
        let albumrow = pickerView.selectedRow(inComponent: albumComponent)
        choiceLabel.text = "You like \(albums[albumrow]) by \(artists[artistrow])"
    }
    
    
    //anything you want the app to do the first time the load is loaded into memory - when an app starts 
    //if you want to do something everytime the view loads - viewDidAppear
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //when get datafile is going to be called to obtain path to plist
        guard let path = getDataFile() else {
            print("Error loading file")
            return
        }
        //code that runs if not empty 
        //NSDictionary: Objective C version of dictionary - has method contentsOfFile
        //assign to artistAlbums, which is a Swift dictionary; casting below to change
        //need to use NS because of content file; need to cast as something more specific (use as) - force unwrap because know that you can cast
        artistAlbums = NSDictionary(contentsOfFile: path) as! [String:[String]]
        //creating keys
        artists = Array(artistAlbums.keys)
        //album will be loaded for the first artist
        albums = artistAlbums[artists[0]]! as [String]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
