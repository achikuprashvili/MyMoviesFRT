//
//  DiscoveryRouter.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation
import UIKit

class DiscoveryRouter: MVVMRouter {
    
    enum PresentationContext {
        case fromCoordinator
    }
    
    enum RouteType {
        case showMovie(movie: Movie)
    }
    
    weak var baseViewController: UIViewController?
    let dependencies: AppDependencies
    
    //==============================================================================
    
    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
    
    //==============================================================================
    
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
        guard let presentationContext = context as? PresentationContext else {
            assertionFailure("The context type missmatch")
            return
        }
        
        guard let nc = baseVC as? UINavigationController else {
            assertionFailure("The baseVC should be UINavigationController")
            return
        }
        baseViewController = baseVC
        
        let vc = DiscoveryVC.instantiateFromStoryboard(storyboardName: "Discovery", storyboardId: "DiscoveryVC")
        let viewModel = DiscoveryVM.init(with: self, tmdbManager: dependencies.tmdbManager)
        vc.viewModel = viewModel
        
        switch presentationContext {
        
        case .fromCoordinator:
            nc.viewControllers = [vc]
        }
    }
    
    //==============================================================================
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        guard let routeType = context as? RouteType else {
            assertionFailure("The route type missmatches")
            return
        }
        
        guard let nc = baseViewController as? UINavigationController else {
            assertionFailure("The baseVC should be UINavigationController")
            return
        }
        
        switch routeType {
            
        case .showMovie(let movie):
            let movieRouter = MovieRouter(dependencies: dependencies)
            let presentationContext = MovieRouter.PresentationContext.fromDiscovery(movie: movie)
            movieRouter.present(on: nc, animated: animated, context: presentationContext, completion: nil)
        }
    }
    
    //==============================================================================
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        guard let nc = baseViewController as? UINavigationController else {
            assertionFailure("The baseVC should be UINavigationController")
            return
        }
        nc.popViewController(animated: true)
    }
    
    //==============================================================================
}
