//
//  AZBannerView.swift
//  AZUIScrollViewBanner
//
//  Created by wanghaohao on 2019/11/23.
//  Copyright © 2019 whao. All rights reserved.
//

import UIKit

enum AZBannerDirection {
    case horizontal
    case vertical
}

class AZBannerView: UIView {
    private let scrollView = AZBannerScrollView()
    private var _direction:AZBannerDirection = .horizontal
    var direction:AZBannerDirection {
        get {
            return _direction
        }
        set {
            _direction = newValue
            resizeBannerItemViews()
        }
    }
    private var padding:CGFloat = 0
    private var _margin:CGFloat = 0
    var margin:CGFloat {
        get {
            return _margin
        }
        set {
            _margin = newValue
            padding = _margin
            resizeBannerItemViews()
        }
    }
    private var _imageUrlTexts:[String] = [String]()
    var imageUrlTexts:[String] {
        get {
            return _imageUrlTexts
        }
        set {
            let flag = _imageUrlTexts.elementsEqual(newValue)
            if flag == true {return}
            _imageUrlTexts = newValue
            createBannerItemViews()
        }
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            let flag = super.frame.equalTo(newValue)
            if flag == true {return}
            super.frame = newValue
            resizeBannerItemViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        setUpSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpSubviews() {
        self.backgroundColor = .yellow
        self.addSubview(scrollView)
        scrollView.isPagingEnabled = true
        scrollView.clipsToBounds = false
        scrollView.frame = self.bounds
        margin = 0
    }
    private func resizeBannerItemViews() {
        var rect = self.bounds
        if _direction == .horizontal {
            rect.origin.x = _margin
            rect.size.width = rect.size.width - _margin
            scrollView.frame = rect
        } else if _direction == .vertical {
            rect.origin.y = _margin
            rect.size.height = rect.size.height - _margin
            scrollView.frame = rect
        }
        var index:Int = 0
        let scrollViewSize = scrollView.bounds.size
        scrollView.subviews.forEach { (view) in
            if _direction == .horizontal {
                view.frame = CGRect(x: (scrollViewSize.width) * CGFloat(index), y: 0, width: scrollViewSize.width - padding, height: scrollViewSize.height)
            } else if _direction == .vertical {
                view.frame = CGRect(x: 0, y: (scrollViewSize.height) * CGFloat(index), width: scrollViewSize.width, height: scrollViewSize.height - padding)
            }
            index += 1
        }
        guard let imageview = scrollView.subviews.last else {
            scrollView.contentSize = .zero
            return
        }
        if _direction == .horizontal {
            scrollView.contentSize = CGSize(width: imageview.frame.maxX + padding, height: 0)
        } else if _direction == .vertical {
            scrollView.contentSize = CGSize(width: 0, height: imageview.frame.maxY + padding)
        }
    }
    private func createBannerItemViews() {
        scrollView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        var index:Int = 0
        let scrollViewSize = scrollView.bounds.size
        _imageUrlTexts.forEach { (imageUrlText) in
            let label = UILabel()
            label.text = imageUrlText
            label.backgroundColor = .red
            label.textAlignment = .center
            scrollView.addSubview(label)
            if _direction == .horizontal {
                label.frame = CGRect(x: (scrollViewSize.width) * CGFloat(index), y: 0, width: scrollViewSize.width - padding, height: scrollViewSize.height)
            } else if _direction == .vertical {
                label.frame = CGRect(x: 0, y: (scrollViewSize.height) * CGFloat(index), width: scrollViewSize.width, height: scrollViewSize.height - padding)
            }
            index += 1
        }
        guard let imageview = scrollView.subviews.last else {
            scrollView.contentSize = .zero
            return
        }
        if _direction == .horizontal {
            scrollView.contentSize = CGSize(width: imageview.frame.maxX + padding, height: 0)
        } else if _direction == .vertical {
            scrollView.contentSize = CGSize(width: 0, height: imageview.frame.maxY + padding)
        }
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if super.hitTest(point, with: event) == self {
            return scrollView
        }
        return super.hitTest(point, with: event)
    }
}

class AZBannerScrollView:UIScrollView {
    
}
