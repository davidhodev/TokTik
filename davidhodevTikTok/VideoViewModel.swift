//
//  VideoViewModel.swift
//  davidhodevTikTok
//
//  Created by David Ho on 5/21/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation

struct VideoViewModel {
    private let video: Video
    
    init(video: Video) {
        self.video = video
    }
    
    var getURLString: String {
        return video.url
    }
}
