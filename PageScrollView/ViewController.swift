//
//  ViewController.swift
//  PageScrollView
//
//  Created by musajan on 2017/8/28.
//  Copyright © 2017年 musajan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // 创建滚动视图view
        var vc = [UIViewController]()
        
        for _ in 0..<4 {
            
            let  v = UIViewController()

            vc.append(v)
        }
        
        let pageScroll = PageScrollView(frame: view.bounds,titleArray: ["LOL","DOTA","魔兽世界","激战2"],vcArray:vc,controller: self)
        
        // 设置滚动视图的按钮标题
        //
        view.addSubview(pageScroll)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

