//
//  PageTitleView.swift
//  PageScrollView
//
//  Created by musajan on 2017/8/28.
//  Copyright © 2017年 musajan. All rights reserved.
//

import UIKit


protocol PageTitleViewDelegate: class {
    
    func clickTitleView(index: Int)
}
class PageTitleView: UIView {

    
    let pModel = PageModel()
    
    var selectLabel: UILabel?
    
    weak var delegate: PageTitleViewDelegate?
    
    var gesArray = [UITapGestureRecognizer]()
    
    
     init(frame: CGRect, titleArray:Array<String>) {
        
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.yellow
        
        addLabelWithTitleArray(titleArray: titleArray)
    }
    
    func addLabelWithTitleArray(titleArray: Array<String>)  {
        
        let contentView = creatScrollView()
        contentView.contentSize = CGSize.init(width: CGFloat(titleArray.count*pModel.titleViewLabelWidth), height: bounds.size.height)
        
        for i in 0..<titleArray.count {
            let titleLabel = creatTitleLabel(title: titleArray[i], frame: CGRect.init(x: i*pModel.titleViewLabelWidth, y: 0, width: pModel.titleViewLabelWidth, height: Int(bounds.size.height)))
            titleLabel.tag = i + 1
            titleLabel.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(titleLableTap))
            titleLabel.addGestureRecognizer(tapGes)
            if i == 0 {
                titleLabel.textColor = UIColor.red
                selectLabel = titleLabel
            }

            contentView.addSubview(titleLabel)
            self.gesArray.append(tapGes)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PageTitleView{

    func creatTitleLabel(title: String,frame: CGRect) -> UILabel {
        let titleLabel = UILabel(frame: frame)
        titleLabel.text = title
        titleLabel.textAlignment = .center
        return titleLabel
    }
    func creatScrollView() -> UIScrollView {
        
        let scrollView = UIScrollView(frame: bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        addSubview(scrollView)
        return scrollView
        
    }
}
extension PageTitleView{

    func titleLableTap(tap: UITapGestureRecognizer)  {
        
        if (selectLabel != nil) {
            selectLabel?.textColor = UIColor.black
            
        }
        let label = tap.view as! UILabel
        label.textColor = UIColor.red
        selectLabel = label
        print("点击label")
        
        delegate?.clickTitleView(index: label.tag - 1)
        
    }
}
extension PageTitleView: PageContentViewDelegate{

    func scrollToIndex(index: Int) {
        
        let  tap  = self.gesArray[index]
        titleLableTap(tap: tap)
        
    }
}
