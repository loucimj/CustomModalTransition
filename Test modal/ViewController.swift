//
//  ViewController.swift
//  Test modal
//
//  Created by Javier Loucim on 20/02/2019.
//  Copyright © 2019 Javier Loucim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ModalTransitionPresenter {
    
    var transitionDelegate = ModalTransitionDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func presentAction(_ sender: Any) {
        let viewController = ModalViewController.initFromStoryboard()
        presentModalWithCustomTransition(viewController: viewController)
    }
    
}
