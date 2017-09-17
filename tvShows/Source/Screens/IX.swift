//
//  IX.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 17/09/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

protocol Interactor {
    associatedtype ViewModel
    
    var vm: ViewModel {get}
    
    init(viewModel: ViewModel)
}
