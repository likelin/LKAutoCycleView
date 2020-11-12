//
//  KKMainViewController.swift
//  SwiftDemo
//
//  Created by kelin on 2020/11/10.
//

import Foundation
import UIKit

class TestData: NSObject {
    public static func datas() -> [[String:String]] {
        return [
            ["text":"本地图片","vc":"LocalImageController"],
            ["text":"网络图片","vc":"NetImageController"],
            ["text":"自定义每个page的样式","vc":"CustomPageController"],
            ["text":"复杂用法","vc":"ComplexPageController"]
        ]
    }
    
    public static func localImages() -> [String] {
        return [
            "1.png",
            "2.png",
            "3.png",
            "4.png"
        ];
    }
    
    public static func netImages() -> [String] {
        return [
            "https://icweiliimg6.pstatp.com/weili/l/378712400698146835.jpg",
            "https://icweiliimg6.pstatp.com/weili/l/903360033333313563.jpg",
            "https://weiliicimg1.pstatp.com/weili/l/812099039242354699.jpg",
            "https://icweiliimg1.pstatp.com/weili/l/812022923831934995.jpg"
        ];
    }
    
    public static func cycle1Datas() -> [[String:String]] {
        return [
            ["image":"1.png", "title":"这是第一张图片"],
            ["image":"2.png", "title":"这是第二张图片"],
            ["image":"3.png", "title":"这是第三张图片"],
            ["image":"4.png", "title":"这是第四张图片"],
        ];
    }
    
    
    public static func cycle2Datas() -> [[String:String]] {
        return [
            ["image":"https://icweiliimg6.pstatp.com/weili/l/378712400698146835.jpg", "title":"第一张网络图片【草原】"],
            ["image":"https://icweiliimg6.pstatp.com/weili/l/903360033333313563.jpg", "title":"第二张网络图片【公路】"],
            ["image":"https://weiliicimg1.pstatp.com/weili/l/812099039242354699.jpg", "title":"第三张网络图片【灯笼】"],
            ["image":"https://icweiliimg1.pstatp.com/weili/l/812022923831934995.jpg", "title":"第四张网络图片【雪山】"],
        ];
    }

}

class KKMainViewCongtroller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.initViews()
    }
    
    func initViews() -> Void {
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.view.addSubview(self.tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TestData.datas().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifer:String = "identifer"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifer)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifer)
            cell?.selectionStyle = .none
            cell?.textLabel?.text = TestData.datas()[indexPath.row]["text"]
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workName = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
        let vcName:String = TestData.datas()[indexPath.row]["vc"]!
        let class_vc = NSClassFromString("\(workName).\(vcName)") as! UIViewController.Type
        self.navigationController?.pushViewController(class_vc.init(), animated: true)
    }
    
}
