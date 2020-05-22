//
//  Service.swift
//  davidhodevTikTok
//
//  Created by David Ho on 5/21/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ServiceProtocol {
    func fetchVideos() -> Observable<[Video]>
}

class Service: ServiceProtocol {
    func fetchVideos() -> Observable<[Video]> {
        return Observable.create { observer -> Disposable in
            guard let path = Bundle.main.path(forResource: "videos", ofType: "json") else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return Disposables.create { }
                }
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let videos = try JSONDecoder().decode([Video].self, from: data)
                observer.onNext(videos)
            } catch {
                observer.onError(error)
            }
            return Disposables.create { }
        }
    }
}
