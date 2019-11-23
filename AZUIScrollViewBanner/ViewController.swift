//
//  ViewController.swift
//  AZUIScrollViewBanner
//
//  Created by wanghaohao on 2019/11/23.
//  Copyright © 2019 whao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let bannerView = AZBannerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(bannerView)
        bannerView.imageUrlTexts = ["1", "2", "3"]
        bannerView.frame = CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: 300)
        bannerView.margin = 33
        bannerView.direction = .vertical
    }


}

