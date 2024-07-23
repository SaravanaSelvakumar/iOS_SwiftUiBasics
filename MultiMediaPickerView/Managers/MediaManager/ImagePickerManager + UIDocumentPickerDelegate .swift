//
//  ImagePickerManager + UIDocumentPickerDelegate .swift
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

extension ImagePickerManager: UIDocumentPickerDelegate  {

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        let filePath = url.tempFileToPermanentStorage()
        if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            documentDelegate?.didSelectDocument(docData: data, docFilePath: filePath, documentUrl: url)
        }
    }
}

extension URL {
  func tempFileToPermanentStorage() -> String {
    var filePath = path
    var newURL = FileManager.getDocumentsDirectory()
    newURL.appendPathComponent(lastPathComponent)
    do {
      if FileManager.default.fileExists(atPath: newURL.path) {
        try FileManager.default.removeItem(atPath: newURL.path)
      }
      try FileManager.default.moveItem(atPath: path, toPath: newURL.path)
      filePath = newURL.path
    } catch {
      print(error.localizedDescription)
    }
    return filePath
  }
}


extension FileManager {
  static func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
  }
  func directoryExists(atUrl url: URL) -> Bool {
   var isDirectory: ObjCBool = false
   let exists = fileExists(atPath: url.path, isDirectory: &isDirectory)
   return exists && isDirectory.boolValue
 }
}
