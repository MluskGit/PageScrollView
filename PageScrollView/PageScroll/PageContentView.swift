//
//  PageContentView.swift
//  PageScrollView
//
//  Created by musajan on 2017/8/28.
//  Copyright © 2017年 musajan. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    
    func scrollToIndex(index: Int)
}
private let kLSKContentViewCellID = "kLSKContentViewCellID"
class PageContentView: UIView {


    var dataArray: Array<UIViewController>
    var vc: UIViewController
    weak var delegate: PageContentViewDelegate?
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:kLSKContentViewCellID)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        return collectionView
    }()
    init(frame: CGRect, dataArray:Array<UIViewController>, controller: UIViewController) {
        self.dataArray = dataArray
        self.vc = controller
        super.init(frame: frame)
        backgroundColor = UIColor.orange
        setUp()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView{

    func setUp() {
        for subVc in self.dataArray {
            
            self.vc.addChildViewController(subVc)
        }
        
        addSubview(self.collectionView)
    }
}
extension PageContentView: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: kLSKContentViewCellID, for: indexPath)
        for view in collectionCell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let vc = self.dataArray[indexPath.row]
        switch indexPath.row {
        case 0:
            vc.view.backgroundColor = UIColor.orange
        case 2:
            vc.view.backgroundColor = UIColor.red
        default:
            vc.view.backgroundColor = UIColor.white
        }
        collectionCell.contentView.addSubview(vc.view)
        return collectionCell
        
    }

}
extension PageContentView: UICollectionViewDataSource{
    @available(iOS 6.0, *)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }



}
extension PageContentView{

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x / self.collectionView.bounds.width
        delegate?.scrollToIndex(index: Int(offsetX))
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}
extension PageContentView: PageTitleViewDelegate{

    func clickTitleView(index: Int) {
        
        let indexP = IndexPath(row: index, section: 0)
        
        self.collectionView.scrollToItem(at: indexP, at: .centeredHorizontally, animated: false)
    }
}
