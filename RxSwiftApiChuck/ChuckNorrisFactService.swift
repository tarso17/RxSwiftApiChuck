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


enum SearchError: Error {
    case jsonError
    case notFound
    case internetError
    case atLeast3Letters
    case error
    
    var description: String {
        switch self {
        case .jsonError:
            return "Error Json Parse"
        case .notFound:
            return "Nothing Found"
        case .internetError:
            return "Internet Error"
        case .atLeast3Letters:
            return "Type at least 3 letters to start"
        default:
            return "Error"
            
        }
    }
    
}

class ChuckNorrisFactService: ChuckNorrisFactServiceProtocol {
    
    
    func fetchFacts(_ fact:String) -> Observable<[ChuckNorrisFact]>{
        
        return Observable.create { observer -> Disposable in
            
            let task = URLSession.shared.dataTask(with: URL(string: K.apiUrl+"search?query=\(fact)")!){
                data, response , _ in
                let httpResponse = response as? HTTPURLResponse
                
                if httpResponse?.statusCode == 400{
                    observer.onError(SearchError.atLeast3Letters)
                    return
                }
                
                
                guard let data = data else {
                    
                    observer.onError(SearchError.error)
                    print("Ocorreu um erro")
                    return
                }
                do {
                    let facts = try JSONDecoder().decode(Result.self, from: data).result
                    observer.onNext(facts)
                    if facts.isEmpty {
                        observer.onError(SearchError.notFound)
                    }
                }
                catch{
                    observer.onError(SearchError.jsonError)
                }
                
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
                
            }
        }
        
        
    }
}


