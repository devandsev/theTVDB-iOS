//
//  BaseViewController.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 17/09/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
}

protocol ViewController {
    associatedtype ViewModel
    associatedtype Interactor
    associatedtype Wireframe
    
    var vm: ViewModel {get}
    var ix: Interactor {get}
    
    init(viewModel: ViewModel, interactor: Interactor, wireframe: Wireframe)
}
