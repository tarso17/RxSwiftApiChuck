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
    private let errorSubject = PublishSubject<String>()
    var error: Driver<String> {
        return errorSubject
            .asDriver(onErrorJustReturn: "")
    }
    
    private let statusViewSubject = PublishSubject<Bool>()
    var status: Driver<Bool> {
        return statusViewSubject
            .asDriver(onErrorJustReturn: true)
    }
    
    private let isLoadingSubject = PublishSubject<Bool>()
    var isLoading: Driver<Bool> {
        return statusViewSubject
            .asDriver(onErrorJustReturn: true)
    }
    
    private let chuckNorrisFactService: ChuckNorrisFactServiceProtocol
    
    init(chuckNorrisFactService:ChuckNorrisFactServiceProtocol = ChuckNorrisFactService()){
        self.chuckNorrisFactService = chuckNorrisFactService
        
    }
    
    func fetchFactViewModels(_ fact:String) -> Observable<[ChuckNorrisFactViewModel]>{
        
        if fact.isEmpty {
            self.statusViewSubject.onNext(false)
            self.isLoadingSubject.onNext(false)
            self.errorSubject.onNext("Search for a Chuck Norris Fact")
            return .just([])
        }
        if fact.count < 3{
            self.statusViewSubject.onNext(false)
            self.isLoadingSubject.onNext(false)
            self.errorSubject.onNext(SearchError.atLeast3Letters.description)
            return .just([])
        }
        
        self.statusViewSubject.onNext(true)
        self.isLoadingSubject.onNext(true)
        return chuckNorrisFactService.fetchFacts(fact).map {$0 .map {ChuckNorrisFactViewModel(fact: $0)} }.catchError { (error) -> Observable<[ChuckNorrisFactViewModel]> in
            let erro = error as! SearchError
            self.statusViewSubject.onNext(false)
            self.isLoadingSubject.onNext(false)
            self.errorSubject.onNext(erro.description)
            
            return .just([])
        }
        
    }
    
    
}





