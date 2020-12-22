//
//  ChuckNorrisFact.swift
//  RxSwiftApiChuck
//
//  Created by Saulo Oliveira on 22/12/20.
//  Copyright © 2020 Saulo Oliveira. All rights reserved.
//

import Foundation

struct ChuckNorrisFact: Decodable {
    let value: String
    let categories: [String]
}

struct Result: Decodable {
    let result: [ChuckNorrisFact]
}

