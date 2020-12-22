//
//  ViewController.swift
//  RxSwiftApiChuck
//
//  Created by Saulo Oliveira on 22/12/20.
//  Copyright © 2020 Saulo Oliveira. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        print("ViewDidLoad")
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = .onDrag
        // Do any additional setup after loading the view.
    }
    
    static func instanciate() -> HomeViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! HomeViewController
        return viewController
    }


}

