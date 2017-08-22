//
//  TableViewController.swift
//  ViewControllerAnimationDemo
//
//  Created by Kaibo Lu on 2017/7/12.
//  Copyright © 2017年 Kaibo Lu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIViewControllerTransitioningDelegate {

    private var presentInteractionController: UIPercentDrivenInteractiveTransition?
    private weak var dismissInteractionController: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        let interactView = UIView(frame: CGRect(x: 0, y: view.bounds.height - 164, width: view.bounds.width, height: 100))
        interactView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        view.addSubview(interactView)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(interactViewPanned(_:)))
        interactView.addGestureRecognizer(pan)
        
        let label = UILabel()
        label.text = "Swipe right"
        label.sizeToFit()
        label.center = CGPoint(x: interactView.bounds.width / 2, y: interactView.bounds.size.height / 2)
        interactView.addSubview(label)
    }
    
    @objc private func interactViewPanned(_ pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            presentInteractionController = UIPercentDrivenInteractiveTransition()
            // Start presenting
            let vc = ViewController()
            vc.transitioningDelegate = self;
            let dismissController = UIPercentDrivenInteractiveTransition()
            dismissInteractionController = dismissController
            vc.dismissInteractionController = dismissController
            present(vc, animated: true, completion: nil)
            
        case .changed:
            guard let controller = presentInteractionController else { return }
            // Update the completion percentage of the transition
            let percent = max(pan.translation(in: pan.view).x, 0) / view.bounds.width
            controller.update(percent)
            
        case .cancelled, .ended:
            guard let controller = presentInteractionController else { return }
            // Slow down animation before finishing or canceling
            // There will be UI bug without slowing down
            controller.completionSpeed = 0.9
            if max(pan.translation(in: pan.view).x, 0) / view.bounds.width > 0.5 {
                // Finish presenting
                controller.finish()
            } else {
                // Cancel presenting
                controller.cancel()
            }
            presentInteractionController = nil
        default:
            break
        }
    }
    
    // MARK: - Table view data source
    
    private let titles: [String] = ["Default",
                                    "Over full screen",
                                    "Over current context",
                                    "Flip horizontal",
                                    "Cross dissolve",
                                    "Partial curl",
                                    "Custom transition"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ViewController()
        switch indexPath.row {
        case 0:
            // Default condition
            // Presentation style: full screen
            // Transition style: cover vertical
            break
        case 1:
            vc.modalPresentationStyle = .overFullScreen
        case 2:
            vc.modalPresentationStyle = .overCurrentContext
        case 3:
            vc.modalTransitionStyle = .flipHorizontal
        case 4:
            vc.modalTransitionStyle = .crossDissolve
        case 5:
            vc.modalTransitionStyle = .partialCurl
        case 6:
            vc.transitioningDelegate = self
        default:
            break
        }
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - View controller transitioning delegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = VCTransitionAnimator()
        animator.presenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = VCTransitionAnimator()
        animator.presenting = false
        return animator
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return presentInteractionController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return dismissInteractionController
    }

}
