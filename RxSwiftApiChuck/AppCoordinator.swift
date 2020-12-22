//
//  AppCoordinator.swift
//  RxSwiftApiChuck
//
//  Created by Saulo Oliveira on 22/12/20.
//  Copyright © 2020 Saulo Oliveira. All rights reserved.
//

import Foundation
import UIKit
class AppCoordinator {
    private let window:  UIWindow
    init(window: UIWindow){
        self.window = window
        
    }
    func start(){
        let viewController = HomeViewController.instanciate()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
}
