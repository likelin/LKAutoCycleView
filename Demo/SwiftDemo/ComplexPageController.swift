//
//  ComplexPageController.swift
//  SwiftDemo
//
//  Created by kelin on 2020/11/10.
//

import Foundation
import SDWebImage

class ComplexPageController: UIViewController, KKAutoCycleScrollViewDelegate, KKAutoCycleScrollViewDataSource {
    
    var cycleView1:KKAutoCycleScrollView!
    var cycleView2:KKAutoCycleScrollView!
    var pageContrl1:UIPageControl!
    var pageContrl2:UIPageControl!
    var titleLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "网络图片加载"
        self.view.backgroundColor = UIColor.white
        
        self.initCycleView1()
        self.initCycleView2()
        self.cycleView1.scrollToIndex(index: 1, animated: false)
    }
    
    func initCycleView1() -> Void {

        self.cycleView1 = KKAutoCycleScrollView(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 200))
        self.cycleView1.delegate = self;
        self.cycleView1.dataSource = self;
        self.cycleView1.autoCycle = false
        
        self.pageContrl1 = UIPageControl(frame: CGRect(x: (self.cycleView1.frame.size.width - 200)/2, y: self.cycleView1.frame.maxY - 40, width: 200, height: 50))
        self.pageContrl1.pageIndicatorTintColor = UIColor.white
        self.pageContrl1.currentPageIndicatorTintColor = UIColor.blue
        self.pageContrl1.numberOfPages = TestData.cycle1Datas().count
        self.pageContrl1.addTarget(self, action: #selector(ComplexPageController.pageChange(_:)), for: .valueChanged)
        if #available(iOS 14.0, *) {
            self.pageContrl1.allowsContinuousInteraction = true
        }
        
        self.view.addSubview(self.cycleView1)
        self.view.addSubview(self.pageContrl1)
        
        self.cycleView1.create()
    }
    
    func initCycleView2() -> Void {

        self.cycleView2 = KKAutoCycleScrollView(frame: CGRect(x: 0, y: self.cycleView1.frame.maxY + 30, width: self.view.frame.size.width, height: 200))
        self.cycleView2.delegate = self;
        self.cycleView2.dataSource = self;
        self.cycleView2.autoCycle = true
        self.cycleView2.create()
        
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: self.cycleView2.frame.maxY - 40, width: self.cycleView2.frame.size.width, height: 40))
        self.titleLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.titleLabel.textColor = UIColor.white
        
        self.pageContrl2 = UIPageControl(frame: CGRect(x: self.cycleView2.frame.size.width - 150, y: self.cycleView2.frame.maxY - 40, width: 200, height: 40))
        self.pageContrl2.pageIndicatorTintColor = UIColor.white
        self.pageContrl2.currentPageIndicatorTintColor = UIColor.blue
        self.pageContrl2.numberOfPages = TestData.cycle2Datas().count
        self.pageContrl2.isUserInteractionEnabled = false
        self.pageContrl2.addTarget(self, action: #selector(ComplexPageController.pageChange(_:)), for: .valueChanged)
        
        self.view.addSubview(self.cycleView2)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.pageContrl2)
        
        self.cycleView2.create()
    }
    
    @objc func pageChange(_ sender:UIPageControl) -> Void {
        if self.pageControlCanContinuousInteraction(pageControl: sender) {
            self.cycleView1.scrollToIndex(index: sender.currentPage, animated: false)
        } else {
            self.cycleView1.scrollToIndex(index: sender.currentPage, animated: true)
        }
    }
    
    private func pageControlCanContinuousInteraction(pageControl:UIPageControl) -> Bool {
        if #available(iOS 14.0, *) {
            if !pageControl.allowsContinuousInteraction {
                return false
            }
            let gestures:[UIGestureRecognizer] = pageControl.gestureRecognizers!
            for gesture in gestures {
                if gesture.state == .failed || gesture.state == .ended {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    /**
     
     - (void)pageChange:(UIPageControl *)pageControl {
         if ([self pageControlCanContinuousInteraction:pageControl]) {
             [self.cycleView1 scrollToIndex:pageControl.currentPage animated:NO];
         } else {
             [self.cycleView1 scrollToIndex:pageControl.currentPage animated:YES];
         }
     }

     - (BOOL)pageControlCanContinuousInteraction:(UIPageControl *)pageControl {
         if (@available(iOS 14.0, *)) {
             if (!pageControl.allowsContinuousInteraction) {
                 return NO;
             }
             NSArray *gestures = [pageControl gestureRecognizers];
             for (UIGestureRecognizer *gesture in gestures) {
                 if (gesture.state == UIGestureRecognizerStateFailed ||
                     gesture.state == UIGestureRecognizerStateEnded) {
                     return NO;
                 }
             }
             return YES;
         }
         return NO;
     }
     
     */
    
    func numberOfViewCountInCycleView(cycle: KKAutoCycleScrollView) -> NSInteger {
        if cycle == self.cycleView1 {
            return TestData.cycle1Datas().count
        }
        if cycle == self.cycleView2 {
            return TestData.cycle2Datas().count
        }
        return 0
    }
    
    func cycleViewAddSubViewsInPageViewAtIndex(cycle: KKAutoCycleScrollView, pageView: UIView, index: NSInteger) {
        if cycle == self.cycleView1 {
            let imageView = UIImageView(frame: pageView.bounds)
            imageView.image = UIImage(named: TestData.cycle1Datas()[index]["image"]!)
            pageView.addSubview(imageView)
            
            let label = UILabel(frame: CGRect(x: 0, y: pageView.frame.size.height - 40, width: pageView.frame.size.width, height: 40))
            label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            label.text = TestData.cycle1Datas()[index]["title"]
            label.textColor = UIColor.white
            pageView.addSubview(label)
        }
        
        if cycle == self.cycleView2 {
            let imageView = UIImageView(frame: pageView.bounds)
            imageView.sd_setImage(with: URL(string: TestData.cycle2Datas()[index]["image"]!), completed: nil)
            pageView.addSubview(imageView)
        }
    }
    
    func cycleViewDidClickPageViewAtIndex(cycleView: KKAutoCycleScrollView, index: NSInteger) {
        print("current page is %ld", index)
    }
    
    func cycleViewOuterViewScrollingIndex(cycleView: KKAutoCycleScrollView, index: NSInteger) {
        if cycleView == self.cycleView1 {
            self.pageContrl1.currentPage = index
        }
        
        if cycleView == self.cycleView2 {
            guard self.titleLabel != nil else {return}
            self.titleLabel.text = TestData.cycle2Datas()[index]["title"]!
            self.pageContrl2.currentPage = index
        }
    }
    
    deinit {
        self.cycleView1.destory()
        self.cycleView2.destory()
    }
}
