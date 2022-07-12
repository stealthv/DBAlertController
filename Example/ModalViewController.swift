//
//  ModalViewController.swift
//  DBAlertController
//
//  Created by Dylan Bettermann on 5/12/15.
//  Copyright (c) 2015 Dylan Bettermann. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Modal View Controller"
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismiss as () -> Void))
    }
    
    @objc func dismiss() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
