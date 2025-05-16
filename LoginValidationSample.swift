import uiKit


Class Login { 
var name: String?
var password: String?

func setValues() {
    name = "dvd"
    password = "fvf"
    
    validate(name: name, password: password)
}

func validate(name: String?, password: String?) {
    
    //  guard let userName = name, !userName.isEmpty else {
    //     print("username is empty")
    //     return
    // } 
    
    // guard let passcode = password, !passcode.isEmpty else {
    //     print("password is empty ")
    //   return
    // }
    
    if let username = name, username.isEmpty  {
         print("name is empty")
    } else if let passcode = password,  passcode.isEmpty {
        print("password is empty")
    } else {
    submit()
    }
}

func submit() {
    print ("username : \(name ?? "")")
    print ("password : \(password ?? "")")
}

setValues()
}
