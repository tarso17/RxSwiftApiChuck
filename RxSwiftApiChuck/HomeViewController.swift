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
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    private var viewModel: ChuckNorrisFactsListViewModel!
    
    override func viewDidLoad() {
        print("ViewDidLoad")
        super.viewDidLoad()
        
        activityView.center = self.view.center
        activityView.color = .red
        self.view.addSubview(activityView)
        
        statusLabel.adjustsFontSizeToFitWidth = true
        statusLabel.minimumScaleFactor = 0.2
        viewModel.error.drive(statusLabel.rx.text).disposed(by: disposeBag)
        viewModel.isLoading.drive(activityView.rx.isAnimating).disposed(by: disposeBag)
        viewModel.status.drive(statusView.rx.isHidden).disposed(by: disposeBag)
        
        self.tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellID)
        
        
        let searchResults = searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[ChuckNorrisFactViewModel]> in
                self.activityView.startAnimating()
                self.activityView.isHidden = false
                if query.isEmpty {
                    self.searchBar.placeholder = "Search for a Chuck Norris Fact"
                    return self.viewModel.fetchFactViewModels(self.searchBar.text!)
                }
                return self.viewModel.fetchFactViewModels(self.searchBar.text!)
                
        }.observeOn(MainScheduler.instance)
        
        searchResults.bind(to: tableView.rx.items(cellIdentifier: K.cellID, cellType: FactTableViewCell.self))  {
            (index, fact: ChuckNorrisFactViewModel, cell) in
            self.activityView.stopAnimating()
            cell.bodyLabel.text = fact.body
            cell.categoryLabel.text = fact.category
            cell.shareButton.rx.tap.subscribe(onNext: { (_) in
                self.shareFact(fact.body)
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
    
    func shareFact(_ fact:String){
         let textToShare = ["Chuck Norris Fact: \(fact)"]
         let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
         
         self.present(activityViewController, animated: true, completion: nil)
         
     }
    
    
}

