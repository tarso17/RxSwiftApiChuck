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
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = .onDrag
        // Do any additional setup after loading the view.
    }


}

