//
//  ImagePickerManager + UIImagePickerControllerDelegate.swift
//  Vundee
//
//  Created by Apzzo on 23/03/23.
//

import Foundation
import UIKit
import MobileCoreServices
import QuickLook
import SwiftUI
import Photos
import BSImagePicker


extension ImagePickerManager: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            if mediaType == "public.movie" {
                guard let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else { return }
                do {
                    let videoData = try Data(contentsOf: videoUrl)
                    delegate?.didSelectedVideo(videoData: videoData, imageLocalUrl: videoUrl)
                    picker.dismiss(animated: true, completion: nil)
                } catch let error {
                    print(error.localizedDescription)
                }
            } else {
                if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
                    if mediaType == "public.image" {
                        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let resizedImageData = originalImage.jpeg(.highest) {
                            let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL ?? URL(fileURLWithPath: "")
                            delegate?.didCaptureImage(image: originalImage, imageUrl: imageUrl, imageData: resizedImageData)
                            picker.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            delegate?.cancel()
            picker.dismiss(animated: true, completion: nil)
        }
    }
}


extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest = 0
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1
      }
    
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
      }
        
}
