//
//  BackendManager.swift
//  MyMoviesFRT
//
//  Created by Archil on 7/6/20.
//  Copyright © 2020 Flat Rock Technology. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol BackendManagerProtocol {
    func sendRequest(_ router: RequestRouter) -> Observable<Data>
    func decodableRequest<T>(_ router: RequestRouter) -> Observable<T> where T: Codable
}

class BackendManager: BackendManagerProtocol {

    let disposeBag = DisposeBag()
    
    func sendRequest(_ router: RequestRouter) -> Observable<Data> {
        return Observable<Data>.create { observer in
            let request = AF.request(router)
            
            request.validate().responseJSON { response in
                self.parseResult(response).subscribe(onNext: { (data) in
                    observer.onNext(data)
                    
                }, onError: { (error) in
                    observer.onError(error)
                    
                }).disposed(by: self.disposeBag)
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func decodableRequest<T>(_ router: RequestRouter) -> Observable<T> where T : Decodable, T : Encodable {
        
        return Observable<T>.create { observer in
            self.sendRequest(router).subscribe(onNext: { (data) in
                do {
                    let decodeObject = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(decodeObject)
                } catch {
                    observer.onError(error)
                }
            }, onError: { (error) in
                observer.onError(error)
            }).disposed(by: self.disposeBag)
            
            return Disposables.create {
            }
        }
    }
    
    func parseResult(_ response: AFDataResponse<Any>) -> Observable<Data> {
        return Observable.create { observer in
            switch response.result {
                
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    observer.onNext(jsonData)
                } catch {
                    observer.onError(error)
                }
            case .failure(let error):
                observer.onError(error)
            }
            
            return Disposables.create {
                
            }
        }
    }
    
}
