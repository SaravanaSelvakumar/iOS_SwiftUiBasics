//
//  ViewController.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies Private Limited on 15/07/24.
//

import Foundation
import UIKit
import Photos
import BSImagePicker

class CameraVC: UIViewController {
    
    static let name  = "CameraVC"
    static let storyBoard  = "Camera"
    
    class func instantiateFromStoryboard() -> CameraVC{
        let vc = UIStoryboard(name: CameraVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: CameraVC.name) as! CameraVC
        return  vc
    }
    
    @IBOutlet var imageV: UIImageView!
    
    
    let imagePicker = ImagePickerManager()
    let redirect = CommunicationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    @IBAction func actionOnBtn(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.openImagePickerUploadSingleImage(viewController: self)
//        imagePicker.showImagePickerForChooseVideo(viewController: self)
//        redirect.redirectToWhatsApp(countryCode: "91", mobileNumber: "9514211669")
        
    }
        
}

extension CameraVC : ImagePickerDelegate  {
    func finish(images: [PHAsset]) {
        print("finish")
    }
    
    func cancel() {
        print("cancel")
    }
    
    func didSelectedVideo(videoData: Data, imageLocalUrl: URL) {
        print("didSelectedVideo")
    }
    
    func didCaptureImage(image: UIImage, imageUrl: URL, imageData: Data) {
        print("didCaptureImage")
        imageV.image = image
    }
        
}
