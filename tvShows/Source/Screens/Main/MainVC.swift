//
//  MainVC.swift
//  perfectReads
//
//  Created by Andrey Sevrikov on 10/07/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import UIKit

class MainVC: UIViewController, HasDependencies {
    
    typealias Dependencies = HasConfigService & HasAPI & HasSessionService
    
    var di: Dependencies!

    @IBOutlet weak var button: UIButton!
    
//    let authenticationAPI = AuthenticationAPI()
//    let config = ConfigService.shared
    
//    let sessionService = SessionService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.di.sessionService.restore(success: {

//            let week: TimeInterval = 7 * 24 * 60 * 60
//            let weekAgo = Date().addingTimeInterval(-week)
//            
//            self.di.api.updates.updatedSince(date: weekAgo, success: { (s) in
//                
//            }, failure: { (e) in
//                
//            })
            
            self.di.api.series.actors(seriesId: 79636, success: { series in
                print(series)
            }, failure: { _ in
                
            })

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
