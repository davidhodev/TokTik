//
//  PageViewController.swift
//  davidhodevTikTok
//
//  Created by David Ho on 5/22/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import AVKit
import AVFoundation

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    private var viewModel: VideoModel!
    let disposeBag: DisposeBag =  DisposeBag()
    private var indexOfVideo: Int!
    private var viewModels: [VideoViewModel]!

    static func instantiate(viewModel: VideoModel) -> PageViewController {
        let vc = PageViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        vc.viewModel = viewModel
        vc.viewModel.fetchVideoModels().subscribe { (video) in
            vc.viewModels = video.element ?? []
        }.disposed(by: vc.disposeBag)
        vc.indexOfVideo = 0
        return vc
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        presentInitialFeed()
        try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
        
        
       }
    
    func presentInitialFeed() {
        let viewController = ViewController.instantiate(videoViewModel: viewModels![0])
        setViewControllers([viewController], direction: .forward, animated: false, completion: nil)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (indexOfVideo == 0) {
            return nil
        }
        
        return ViewController.instantiate(videoViewModel: viewModels[indexOfVideo - 1])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if (indexOfVideo == viewModels.count - 1) {
            return nil
        }
        return ViewController.instantiate(videoViewModel: viewModels[indexOfVideo + 1])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else { return }
        if
            let viewController = pageViewController.viewControllers?.first as? ViewController,
            let previousViewController = previousViewControllers.first as? ViewController
        {
            previousViewController.pause()
            viewController.play()
            indexOfVideo += 1
        }
    }
}
