//
//  Password.swift
//  MultiMediaPickerView
//
//  Created by Apzzo Technologies on 15/07/24.
//

import Foundation


class PasswordValidator {
    
    private var minLength: Int = 8
    private var maxLength: Int = 15
    private var requiresUppercase: Bool = true
    private var requiresLowercase: Bool = true
    private var requiresSpecialCharacter: Bool = true
    
    func setValidationProperties(_ minLength: Int, _ maxLength: Int, _ requiresUppercase: Bool, _ requiresLowercase: Bool, _ requiresSpecialCharacter: Bool) {
        self.minLength = minLength
        self.maxLength = maxLength
        self.requiresUppercase = requiresUppercase
        self.requiresLowercase = requiresLowercase
        self.requiresSpecialCharacter = requiresSpecialCharacter
    }
    
    func validatePassword(_ password: String) -> Bool {
        // Check length
        guard password.count >= minLength && password.count <= maxLength else {
            return false
        }
        
        // Check uppercase requirement
        if requiresUppercase {
            let uppercaseLetterRegex = ".*[A-Z]+.*"
            guard NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex).evaluate(with: password) else {
                return false
            }
        }
        
        // Check lowercase requirement
        if requiresLowercase {
            let lowercaseLetterRegex = ".*[a-z]+.*"
            guard NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegex).evaluate(with: password) else {
                return false
            }
        }
        
        // Check special character requirement
        if requiresSpecialCharacter {
            let specialCharacterRegex = ".*[!@#$%^&*()_+{}|:\"<>?~]+.*"
            guard NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex).evaluate(with: password) else {
                return false
            }
        }
        
        // All criteria met
        return true
    }
}
