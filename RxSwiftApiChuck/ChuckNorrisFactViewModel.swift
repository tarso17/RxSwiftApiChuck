//
//  ChuckNorrisFactViewModel.swift
//  RxSwiftApiChuck
//
//  Created by Saulo Oliveira on 22/12/20.
//  Copyright © 2020 Saulo Oliveira. All rights reserved.
//

import Foundation

struct ChuckNorrisFactViewModel {
    
    
    private let fact: ChuckNorrisFact
    var category: String {
        
        if fact.categories.isEmpty {
            return "UNCATEGORIZED"
        }
        else {
            return fact.categories[0].capitalized
        }
        
        
    }
    var body: String {
        return fact.value
    }
    
    init(fact: ChuckNorrisFact){
        self.fact = fact
        
        
    }
    
}
