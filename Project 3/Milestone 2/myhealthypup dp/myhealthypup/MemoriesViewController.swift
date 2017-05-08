//
//  MemoriesViewController.swift
//  myhealthypup
//
//Tutorial to add camera functionality to app:
//https://turbofuture.com/cell-phones/Access-Photo-Camera-and-Library-in-Swift
//Code to save and load images:
//https://iosdevcenters.blogspot.com/2016/04/save-and-get-image-from-document.html
//
//  Created by Fuji Robledo on 5/3/17.
//  Copyright © 2017 Fuji Robledo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class MemoriesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let sectionInsets = UIEdgeInsets(top:10.0, left: 5.0, bottom: 10.0, right: 5.0)
      
    var memories = [UIImage]()
    var imagePicked : UIImage!
    
    let kfilename = "data.plist"

    //Attempted to create data persistance for images below, but the methods do not store the image array (see commented items). As of now, only the last picture taken is persistent.
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        
//        let path: String?
//        let filePath = docFilePath(kfilename)
//        
//        if FileManager.default.fileExists(atPath: filePath!){
//            path = filePath
//            let savedMemories = NSArray(contentsOfFile: path!) as! [UIImage]
//            print([savedMemories])
//            memories += savedMemories
//        }

    }
    
//    func docFilePath(_ filename: String) -> String? {
//        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
//        let dir = path[0] as NSString
//        return dir.appendingPathComponent(filename)
//    }
//    
//    func saveImage() {
//        print("in applicationwillresignactive")
//        let filePath = docFilePath(kfilename)
//        let data = NSArray()
//        data.addingObjects(from: memories)
//        print([data])
//        data.write(toFile: filePath!, atomically: true)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let image = memories[indexPath.row]
        cell.imageView.image = image
      
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let image = memories[indexPath.row]

        let newSize: CGSize = CGSize(width: (image.size.width)/15, height: (image.size.height)/15)
        
        let rect = CGRect(x:0, y:0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        
        let image2 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return (image2?.size)!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
        
    }
    
    
    @IBAction func getPicture(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String:Any]){
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked = pickedImage
        }
        
        saveImageDocumentDirectory()
        picker.dismiss(animated: true, completion: nil)
        getImage()
    }

    func saveImageDocumentDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("memory.jpg")
        let image = imagePicked
        print(paths)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }

    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    func getImage(){
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent("memory.jpg")
        if fileManager.fileExists(atPath: imagePAth){
            memories.append(UIImage(contentsOfFile: imagePAth)!)
            collectionView?.reloadData()
        }else{
            print("No Image")
        }
    }
 
}
