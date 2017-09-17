//
//  SearchVC.swift
//  tvShows
//
//  Created by Andrey Sevrikov on 17/09/2017.
//  Copyright © 2017 devandsev. All rights reserved.
//

import UIKit

class SearchVC: BaseViewController, ViewController {

    typealias ViewModel = SearchVM
    typealias Interactor = SearchIX
    typealias Wireframe = SearchWF
    
    let vm: ViewModel
    let ix: Interactor
    let wf: Wireframe
    
    // MARK: - IBOutlets
    
    
    // MARK: - Lifecycle
    
    required init(viewModel: ViewModel, interactor: Interactor, wireframe: Wireframe) {
        self.vm = viewModel
        self.ix = interactor
        self.wf = wireframe
        
        super.init(nibName: "SearchVC", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    
    @IBAction func didTapButton(_ sender: UIButton) {
        self.wf.hide(viewController: self)
    }
}

// MARK: - IX Delegate

extension SearchVC: SearchIXDelegate {
    
}
