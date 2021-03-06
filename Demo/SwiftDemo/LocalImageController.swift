//
//  LocalImageController.swift
//  SwiftDemo
//
//  Created by kelin on 2020/11/10.
//

import Foundation
import UIKit

class LocalImageController: UIViewController, KKAutoCycleScrollViewDelegate, KKAutoCycleScrollViewDataSource {
    
    var cycleView:KKAutoCycleScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "本地图片加载"
        self.view.backgroundColor = UIColor.white
        
        self.initCycleView()
    }
    
    func initCycleView() -> Void {

        self.cycleView = KKAutoCycleScrollView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 200))
        self.cycleView.delegate = self;
        self.cycleView.dataSource = self;
        self.cycleView.duration = 2
        self.cycleView.create()
        
        self.view.addSubview(self.cycleView)
    }
    
    func numberOfViewCountInCycleView(cycle: KKAutoCycleScrollView) -> NSInteger {
        return TestData.localImages().count
    }
    
    func cycleViewAddSubViewsInPageViewAtIndex(cycle: KKAutoCycleScrollView, pageView: UIView, index: NSInteger) {
        let imageView = UIImageView(frame: pageView.bounds)
        imageView.image = UIImage(named: TestData.localImages()[index])
        pageView.addSubview(imageView)
    }
    
    func cycleViewDidClickPageViewAtIndex(cycleView: KKAutoCycleScrollView, index: NSInteger) {
        print("current page is %ld", index)
    }
    
    deinit {
        self.cycleView.destory()
    }
}
