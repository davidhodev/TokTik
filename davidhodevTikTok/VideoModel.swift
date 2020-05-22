//
//  VideoModel.swift
//  davidhodevTikTok
//
//  Created by David Ho on 5/21/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class VideoModel {
    private let service: ServiceProtocol
    
    init (service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func fetchVideoModels() -> Observable<[VideoViewModel]> {
        service.fetchVideos().map { $0.map { VideoViewModel(video: $0) } }
    }
}
