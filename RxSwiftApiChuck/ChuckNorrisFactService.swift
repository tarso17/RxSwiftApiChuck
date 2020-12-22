//
//  ChuckNorrisFactService.swift
//  RxSwiftApiChuck
//
//  Created by Saulo Oliveira on 22/12/20.
//  Copyright © 2020 Saulo Oliveira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ChuckNorrisFactServiceProtocol {
    func fetchFacts(_ fact:String) -> Observable<[ChuckNorrisFact]>
}


class ChuckNorrisFactService: ChuckNorrisFactServiceProtocol {
    
    
    func fetchFacts(_ fact:String) -> Observable<[ChuckNorrisFact]>{
        
        return Observable.create { observer -> Disposable in
            
            let task = URLSession.shared.dataTask(with: URL(string: K.apiUrl+"search?query=\(fact)")!){
                data, response , _ in

                guard let data = data else {

                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    print("Error")
                    return
                }
                do {
                    let facts = try JSONDecoder().decode(Result.self, from: data).result
                    observer.onNext(facts)
                    if facts.isEmpty {
                        print("Empty")
                    }
                }
                catch{
                    print("Json Error")
                }
                
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
                
            }
        }
        
        
    }
}

