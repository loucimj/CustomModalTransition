//
//  ModalViewController.swift
//  Test modal
//
//  Created by Javier Loucim on 20/02/2019.
//  Copyright © 2019 Javier Loucim. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    var interactionController: LeftEdgeInteractionController?

    class func initFromStoryboard() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController
        viewController.interactionController = LeftEdgeInteractionController(viewController: viewController)

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func presentAnotherOneAction(_ sender: Any) {
        let viewController = ModalViewController.initFromStoryboard()
        viewController.providesPresentationContextTransitionStyle = true
        viewController.definesPresentationContext = true
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: true, completion: nil)
    }
    
}
