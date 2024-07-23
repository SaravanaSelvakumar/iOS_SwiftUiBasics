//
//  CommunicationManager.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies on 15/07/24.
//

import Foundation
import UIKit

class CommunicationManager {
    
    // MARK: - Redirect to WhatsApp
    
    func redirectToWhatsApp(countryCode: String, mobileNumber: String, message: String? = "") {
        let urlString = "https://api.whatsapp.com/send?phone=\(countryCode)\(mobileNumber)"
        
        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let URL = NSURL(string: urlStringEncoded!)
        
        if UIApplication.shared.canOpenURL(URL! as URL) {
            debugPrint("opening Whatsapp")
            UIApplication.shared.open(URL as! URL, options: [:]) { status in
                debugPrint("Opened WhatsApp Chat")
            }
        } else {
            debugPrint("Can't open")
        }
    }
    
    
    // MARK: - Make Phone Call
    
    func makePhoneCall(phoneNumber: String) {
        let formattedNumber = phoneNumber.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
        
        if let url = NSURL(string: ("tel:" + (formattedNumber))) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
    // MARK: - Redirect to Email
    
    func composeEmail(recipient: String, subject: String? = "", body: String? = "") {
        let email = recipient.replacingOccurrences(of: " ", with: "")
        var urlString = "mailto:\(email)"
        
        var components = URLComponents(string: urlString)
        var queryItems = [URLQueryItem]()
        
        if let encodedSubject = subject?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let subjectItem = URLQueryItem(name: "subject", value: encodedSubject)
            queryItems.append(subjectItem)
        }
        
        if let encodedBody = body?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let bodyItem = URLQueryItem(name: "body", value: encodedBody)
            queryItems.append(bodyItem)
        }
        
        components?.queryItems = queryItems
        
        if let emailURL = components?.url {
            if UIApplication.shared.canOpenURL(emailURL) {
                UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
            } else {
                // Unable to compose email
                print("Unable to compose email.")
                // Optionally, handle this case
            }
        }
    }

    
}
