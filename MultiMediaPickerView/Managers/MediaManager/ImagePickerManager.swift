//
//  ImagePickerManager.swift
//  Vundee
//
//  Created by Apzzo on 14/02/23.
//

import Foundation
import UIKit
import MobileCoreServices
import QuickLook
import SwiftUI
import Photos
import BSImagePicker

/// ImagePickerManager Delegate method
protocol ImagePickerDelegate: AnyObject {
    func finish(images: [PHAsset])
    func cancel()
    func didSelectedVideo(videoData: Data, imageLocalUrl: URL)
    func didCaptureImage(image: UIImage, imageUrl: URL, imageData: Data)
}

protocol DocumentPickerDelegate: AnyObject {
    func didSelectDocument(docData: Data,docFilePath: String, documentUrl: URL)
}

class ImagePickerManager: NSObject, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    
    static let shareInstance = ImagePickerManager()
    weak var delegate: ImagePickerDelegate?
    weak var documentDelegate: DocumentPickerDelegate?
    weak var presentationController: UIViewController?
    let imagePicker = ImagePickerController()
    let imagePickerController = UIImagePickerController()
    let documentTypes = ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key", "public.image", "com.apple.application", "public.item", "public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"]
    var documentData = URL(string: "")
    
    /// Image picker set up init
    func initImagePicker() {
        self.imagePicker.settings.selection.max = 10
        self.imagePicker.settings.theme.selectionStyle = .numbered
        self.imagePicker.settings.fetch.assets.supportedMediaTypes = [.image,.video]
        self.imagePicker.settings.selection.unselectOnReachingMax = true
        self.imagePicker.navigationBar.isTranslucent = false
        self.imagePicker.doneButton.tintColor = UIColor.green
        self.imagePicker.cancelButton.tintColor = UIColor.red
    }
    
    /// We are using this function open image picker more then one image upload when user select max 20 images select and upload
    /// Choose the image picture photo library for select the image
    /// - Parameter viewController: self view controller to pass the view controller
    func openImagePickerUploadMoreImage(viewController: UIViewController) {
        var selectedCount = 0
        viewController.presentImagePicker(imagePicker, select: {_ in
            selectedCount += 1
            if selectedCount > 20 {
                ImagePickerManager.showAlert(message: "Cant' more than 20 pictures", viewController: viewController)
                selectedCount -= 1
            }
        }, deselect: { _ in
        }, cancel: { assets in
            self.delegate?.cancel()
        }, finish: { assets in
            self.delegate?.finish(images: assets)
        }, completion: {})
    }
    
    /// We are using when user upload single image to upload view to image picker using this openImagePickerUploadSingleImage
    /// Choose the image picture photo library for select the image
    /// - Parameter viewController: self view controller to pass the view controller
    func openImagePickerUploadSingleImage(viewController: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            imagePickerController.delegate = self
            imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePickerController.mediaTypes = [kUTTypeImage as String]
            viewController.modalPresentationStyle = .fullScreen
            viewController.present(imagePickerController, animated: true,completion: nil)
        }
    }
    
    func getAssetRealImage(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize.zero, contentMode: .aspectFit, options: option, resultHandler: { (result, _) -> Void in
            thumbnail = result ?? UIImage()
        })
        return thumbnail
    }
    
    /// open the came for capture the image only real device it' not support for simulator other wise show error popup message
    func showImagePickerForCaptureImage(type: String, viewController: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            imagePickerController.mediaTypes = [type]
            viewController.modalPresentationStyle = .fullScreen
            viewController.present(imagePickerController, animated: true, completion: nil)
        } else {
            ImagePickerManager.showAlert(title: "", message: "You don't have camera", viewController: viewController)
        }
    }
    
    /// Open the came for capture video recorder
    func showImagePickerForCaptureVideo(viewController: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            imagePickerController.mediaTypes = ["public.movie"]
            viewController.present(imagePickerController, animated: true, completion: nil)
        } else {
            ImagePickerManager.showAlert(title: "", message: "You don't have camera", viewController: viewController)
        }
    }
    
    /// Choose the image picture photo library for select the image
    /// - Parameter viewController: self view controller to pass the view controller
    func showImagePickerForChooseVideo(viewController: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            imagePickerController.delegate = self
            imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePickerController.mediaTypes = ["public.movie"]
            viewController.modalPresentationStyle = .fullScreen
            viewController.present(imagePickerController, animated: true,completion: nil)
        }
    }
    
    /// We are using in this function show document picker preview setup
    /// - Parameter viewController:
    func initDocumentPicker(viewController: UIViewController) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: documentTypes, in: .import)
        documentPicker.allowsMultipleSelection = true
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .fullScreen
        viewController.present(documentPicker, animated: true)
    }
    
    // QLPreviewControllerDataSource methods
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return documentData! as QLPreviewItem
    }
        
    class func showAlert(title: String = "", message: String, viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        viewController.present(alertController, animated: true, completion: nil)
    }
}
