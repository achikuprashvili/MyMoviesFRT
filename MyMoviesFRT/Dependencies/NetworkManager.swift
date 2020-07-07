//
//  NetworkManager.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/7/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation
import RxSwift
import Reachability
protocol NetworkManagerProtocol {
    var isReachable: BehaviorSubject<Bool> { get }
}

class NetworkManager: NSObject, NetworkManagerProtocol {
    static let shared: NetworkManager = NetworkManager()
    var reachability: Reachability
    var isReachable: BehaviorSubject<Bool> = BehaviorSubject<Bool>.init(value: false)
    
    override init() {
        reachability = try! Reachability()
        
        super.init()
        
        reachability.whenReachable = { _ in
            self.isReachable.onNext(true)
        }
        
        reachability.whenUnreachable = { _ in
            self.isReachable.onNext(false)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
//    func isUnreachable() -> Bool {
//        return reachability.connection == .unavailable
//    }
}
