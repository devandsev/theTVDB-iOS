//
//  SearchWF.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 17/09/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import UIKit

class SearchWF: BaseWireframe, ModuleConstructable {

    required init(with navigationController: UINavigationController) {
        super.init(with: navigationController)
    }
    
    func module() -> UIViewController {
        let vm = SearchVM()
        let ix = SearchIX(viewModel: vm)
        
        let vc = SearchVC(viewModel: vm, interactor: ix, wireframe: self)
        
        ix.delegate = vc
    
        return vc
    }
}
