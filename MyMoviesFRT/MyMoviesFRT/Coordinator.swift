//
//  Coordinator.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/6/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    
    var dependencies: AppDependencies!
    var window: UIWindow?
    var navigationController: UINavigationController
    
    //==============================================================================
    
    init() {
        
        let backendManager = BackendManager()
        dependencies = AppDependencies(backendManager: backendManager)
        navigationController = UINavigationController()

    }
    
    //==============================================================================

    func presentInitialScreen(on window: UIWindow) {
        self.window = window
        window.rootViewController = navigationController
        let discoveryRouter = DiscoveryRouter(dependencies: dependencies)
        let presentationContext = DiscoveryRouter.PresentationContext.fromCoordinator
        discoveryRouter.present(on: navigationController, animated: true, context: presentationContext, completion: nil)
        
        window.makeKeyAndVisible()
    }
    
}

