//
//  ViewController.swift
//  UIImagePickerControllerCamera
//
//  Created by Carlos Butron on 08/12/14.
//  Copyright (c) 2014 Carlos Butron.
//

import UIKit
import MediaPlayer
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var myImage: UIImageView!
    @IBAction func useCamera(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        
        //to select only camera controls, not video
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.showsCameraControls = true
        //imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImagePNGRepresentation(image)! as NSData
        
        //save in photo album
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
        //save in documents
        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last
        let filePath = (documentsPath! as NSString).stringByAppendingPathComponent("pic.png")
        imageData.writeToFile(filePath, atomically: true)
        
        myImage.image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>){
        if(error != nil){
            print("ERROR IMAGE \(error.debugDescription)")
        }
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
