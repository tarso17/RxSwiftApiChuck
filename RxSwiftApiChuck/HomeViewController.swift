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
    private var viewModel: ChuckNorrisFactsListViewModel!
    override func viewDidLoad() {
        print("ViewDidLoad")
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = .onDrag
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellID)
        
        viewModel.fetchFactViewModels("teste").bind(to: tableView.rx.items(cellIdentifier: K.cellID, cellType: FactTableViewCell.self))  {
            (index, fact: ChuckNorrisFactViewModel, cell) in
            cell.bodyLabel.text = fact.body
            cell.categoryLabel.text = fact.category
            cell.shareButton.rx.tap.subscribe(onNext: { (_) in
            }).disposed(by: self.disposeBag)
            
        }
        .disposed(by: disposeBag)
    }
    
    static func instanciate(viewModel:ChuckNorrisFactsListViewModel) -> HomeViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! HomeViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    
}

