//
//  CustomPageController.swift
//  SwiftDemo
//
//  Created by kelin on 2020/11/10.
//

import Foundation
import UIKit
import SDWebImage

class CustomPageController: UIViewController, KKAutoCycleScrollViewDelegate, KKAutoCycleScrollViewDataSource {
    
    var cycleView:KKAutoCycleScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "自定义每个page"
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
        return 3
    }
    
    func cycleViewAddSubViewsInPageViewAtIndex(cycle: KKAutoCycleScrollView, pageView: UIView, index: NSInteger) {
        
        if index == 0 {
            let imageView = UIImageView(frame: pageView.bounds)
            imageView.image = UIImage(named: "1.png")
            pageView.addSubview(imageView)
        }
        
        if index == 1 {
            pageView.backgroundColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
            let label = UILabel(frame: CGRect(x: (pageView.frame.size.width - 200)/2, y: 30, width: 200, height: 60))
            label.backgroundColor = UIColor.black
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textAlignment = .center
            label.text = "这这这..是一个label"
            pageView.addSubview(label)
            
            for i in 0...2 {
                let random1:CGFloat = CGFloat((arc4random() % 255)) / 255.0
                let random2:CGFloat = CGFloat((arc4random() % 255)) / 255.0
                let random3:CGFloat = CGFloat((arc4random() % 255)) / 255.0
                let button = UIButton(type: .system)
                button.frame = CGRect(x: CGFloat(20 * (i + 1) + (80 * i)), y: label.frame.maxY + 10, width: 80, height: 40)
        
                button.backgroundColor = UIColor.init(red: random1, green: random2, blue: random3, alpha: 1.0)
                button.setTitle("button\(i+1)", for: .normal)
                pageView.addSubview(button)
            }
        }
        
        if index == 2 {
            let imageView = UIImageView(frame: pageView.bounds)
            imageView.sd_setImage(with: URL(string: "https://icweiliimg6.pstatp.com/weili/l/378712400698146835.jpg"), completed: nil)
            pageView.addSubview(imageView)
        }
        
    }
    
    func cycleViewDidClickPageViewAtIndex(cycleView: KKAutoCycleScrollView, index: NSInteger) {
        print("current page is %ld", index)
    }
    
    deinit {
        self.cycleView.destory()
    }
}

