//
//  ViewController.swift
//  ViewControllerAnimationDemo
//
//  Created by Kaibo Lu on 2017/7/12.
//  Copyright © 2017年 Kaibo Lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        
        let backButton = UIButton(frame: CGRect(x: view.bounds.width / 2 - 50,
                                                y: view.bounds.height / 2 - 25,
                                                width: 100,
                                                height: 50))
        backButton.backgroundColor = .red
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    @objc private func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}

