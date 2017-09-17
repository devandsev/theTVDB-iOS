//
//  BaseWireframe.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 17/09/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import UIKit

class BaseWireframe: Wireframe {
    
    let navigationController: UINavigationController
    
    required init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show(viewController: UIViewController, modally: Bool = false) {
        if modally {
            self.navigationController.present(viewController, animated: true) {}
        } else {
           self.navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func hide(viewController: UIViewController) {
        guard let lastVC = self.navigationController.viewControllers.last,
        lastVC == viewController else {
            self.navigationController.dismiss(animated: true) {}
            return
        }
        
        self.navigationController.popViewController(animated: true)
    }
}

protocol Wireframe {
    
    var navigationController: UINavigationController {get}
    init(with navigationController: UINavigationController)
}

protocol ModuleConstructable {
    func module() -> UIViewController
}
