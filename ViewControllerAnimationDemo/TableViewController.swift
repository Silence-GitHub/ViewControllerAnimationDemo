//
//  TableViewController.swift
//  ViewControllerAnimationDemo
//
//  Created by Kaibo Lu on 2017/7/12.
//  Copyright © 2017年 Kaibo Lu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
    }
    
    // MARK: - Table view data source
    
    private let titles: [String] = ["Default",
                                    "Over full screen",
                                    "Over current context",
                                    "Flip horizontal",
                                    "Cross dissolve",
                                    "Partial curl"]
    
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
        default:
            break
        }
        present(vc, animated: true, completion: nil)
    }

}
