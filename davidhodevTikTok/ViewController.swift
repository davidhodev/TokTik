//
//  ViewController.swift
//  davidhodevTikTok
//
//  Created by David Ho on 5/21/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AVKit
import AVFoundation

class ViewController: AVPlayerViewController {
//    fileprivate var video: Video!
//    private var viewModel: VideoModel!
    private var videoViewModel: VideoViewModel!
    fileprivate var isPlaying: Bool!
    let disposeBag: DisposeBag =  DisposeBag()
    
    @IBOutlet weak var button: UIButton!
    
    static func instantiate(videoViewModel: VideoViewModel) -> ViewController {
        let vc = ViewController(nibName: "ViewController", bundle: nil)
        vc.videoViewModel = videoViewModel
        vc.isPlaying = false
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(videoViewModel)
        initializeFeed()
        self.view.backgroundColor = .red
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
         player?.pause()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        player?.play()
    }
    
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    fileprivate func initializeFeed() {
        if let url = URL(string: videoViewModel.getURLString) {
            print("HERE", url)
            player = AVPlayer(url: url)
            isPlaying ? play() : nil
        }
    }
}

