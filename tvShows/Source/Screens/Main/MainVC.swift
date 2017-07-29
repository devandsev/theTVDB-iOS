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
    let searchAPI = SearchAPI()
    let config = ConfigService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticationAPI.login(apiKey: config.apiKey, userKey: nil, userName: nil, success: {
//            print("succ")
            
            self.searchAPI.search(name: "game", success: { series in
//                print(series)
            }, failure: { error in
//                print(error.description)
            })
            
        }) { error in
//            print(error.description)
        }
    }
}
