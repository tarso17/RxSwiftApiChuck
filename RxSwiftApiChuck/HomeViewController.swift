//
//  ViewController.swift
//  RxSwiftApiChuck
//
//  Created by Saulo Oliveira on 22/12/20.
//  Copyright © 2020 Saulo Oliveira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class HomeViewController: UIViewController {
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        print("ViewDidLoad")
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = .onDrag
//        ChuckNorrisFactService().fetchFacts("teste").subscribe(onNext: { (facts) in
//            print(facts)
//            }).disposed(by: disposeBag)
    }
    
    static func instanciate() -> HomeViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! HomeViewController
        return viewController
    }
    
    
}

