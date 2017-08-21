//
//  MainVC.swift
//  perfectReads
//
//  Created by Andrey Sevrikov on 10/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    let authenticationAPI = AuthenticationAPI()
    let searchAPI = SearchAPI()
    let seriesAPI = SeriesAPI()
    let config = ConfigService.shared
    
    let sessionService = SessionService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionService.restore(success: { 
            print("v")
        }) { error in
            print(error)
        }
        
//            self.seriesAPI.series(id: 79636, success: { series in
//                print(series)
//            }, failure: { _ in
//
//            })

//            self.searchAPI.search(name: "game", success: { series in
//                print(series)

//            }, failure: { error in
//            })
    }
}
