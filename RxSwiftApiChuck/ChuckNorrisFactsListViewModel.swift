//
//  ChuckNorrisFactsListViewModel.swift
//  RxSwiftApiChuck
//
//  Created by Saulo Oliveira on 22/12/20.
//  Copyright © 2020 Saulo Oliveira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ChuckNorrisFactsListViewModel {
    let title = "Chuck Norris Facts"
    private let chuckNorrisFactService: ChuckNorrisFactServiceProtocol
    
    init(chuckNorrisFactService:ChuckNorrisFactServiceProtocol = ChuckNorrisFactService()){
        self.chuckNorrisFactService = chuckNorrisFactService
        
    }
    
    func fetchFactViewModels(_ fact:String) -> Observable<[ChuckNorrisFactViewModel]>{
        
        if fact.isEmpty {
            return .just([])
        }
        if fact.count < 3{
            return .just([])
        }
        
        return chuckNorrisFactService.fetchFacts(fact).map {$0 .map {ChuckNorrisFactViewModel(fact: $0)} }.catchError { (error) -> Observable<[ChuckNorrisFactViewModel]> in
            return .just([])
        }
        
    }
    
    
    
    
    
}
