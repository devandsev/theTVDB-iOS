//
//  SearchIX.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 17/09/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import Foundation

protocol SearchIXDelegate: class {
    
}

class SearchIX: Interactor {
    typealias ViewModel = SearchVM

    let vm: ViewModel
    weak var delegate: SearchIXDelegate?
    
    required init(viewModel: ViewModel) {
        self.vm = viewModel
    }
}
