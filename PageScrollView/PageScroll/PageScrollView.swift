//
//  PageScrollView.swift
//  PageScrollView
//
//  Created by musajan on 2017/8/28.
//  Copyright © 2017年 musajan. All rights reserved.
//

import UIKit

class PageScrollView: UIView {

    //标题视图数
    var titleArray: Array<String>
    var vcArray = [UIViewController]()
    var vc: UIViewController
    let pModel = PageModel()
    
    init(frame: CGRect, titleArray: Array<String>, vcArray: Array<UIViewController>, controller: UIViewController) {
        self.titleArray = titleArray
        self.vcArray = vcArray
        self.vc = controller
        super.init(frame: frame)
        backgroundColor = UIColor.red
        setUp()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: - titleView
extension PageScrollView{
    
    func setUp()  {
        
        let  titleView = PageTitleView(frame: CGRect.init(x: 0, y: pModel.marginY, width: kScreenWidth, height: pModel.titleViewHeight),titleArray:self.titleArray)
        addSubview(titleView)

        let  contentView = PageContentView(frame: CGRect.init(x: 0, y: pModel.titleViewHeight+pModel.marginY, width: kScreenWidth, height: kScreenHeight - pModel.titleViewHeight - pModel.marginY),dataArray:self.vcArray,controller: self.vc)
        
        addSubview(contentView)
        
        titleView.delegate = contentView
        contentView.delegate = titleView
        
    }
    
}
