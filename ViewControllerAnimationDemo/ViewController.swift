//
//  ViewController.swift
//  ViewControllerAnimationDemo
//
//  Created by Kaibo Lu on 2017/7/12.
//  Copyright © 2017年 Kaibo Lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dismissInteractionController: UIPercentDrivenInteractiveTransition?
    
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
        
        if dismissInteractionController != nil {
            let pan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
            view.addGestureRecognizer(pan)
            
            backButton.setTitle("Swipe left", for: .normal)
            backButton.isUserInteractionEnabled = false
        }
    }
    
    @objc private func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func viewPanned(_ pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            dismiss(animated: true, completion: nil)
            
        case .changed:
            guard let controller = dismissInteractionController else { return }
            let percent = -min(pan.translation(in: view).x, 0) / view.bounds.width
            controller.update(percent)
            
        case .cancelled, .ended:
            guard let controller = dismissInteractionController else { return }
            // Slow down animation before finishing or canceling
            // There will be UI bug without slowing down
            controller.completionSpeed = 0.9
            if -min(pan.translation(in: view).x, 0) / view.bounds.width > 0.5 {
                controller.finish()
            } else {
                controller.cancel()
            }
            
        default:
            break
        }
    }


}

