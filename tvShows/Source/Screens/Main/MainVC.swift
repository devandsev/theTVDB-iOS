//
//  MainVC.swift
//  perfectReads
//
//  Created by Andrey Sevrikov on 10/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    let authenticationAPI = AuthenticationAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticationAPI.login(apiKey: "asd", userKey: nil, userName: nil, success: { token in
            print(token)
        }) { error in
            print(error)
        }
    }
}
