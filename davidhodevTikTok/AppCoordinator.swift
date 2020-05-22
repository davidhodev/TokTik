//
//  AppCoordinator.swift
//  davidhodevTikTok
//
//  Created by David Ho on 5/21/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    private let window: UIWindow
    
    init (window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
//        let viewController = ViewController.instantiate(viewModel: VideoModel())
        let viewController = PageViewController.instantiate(viewModel: VideoModel())
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
