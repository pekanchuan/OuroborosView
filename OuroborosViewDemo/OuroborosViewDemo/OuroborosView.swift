//
//  OuroborosView.swift
//  OuroborosViewDemo
//
//  Created by Chia on 2021/2/27.
//  Copyright © 2021 Chia. All rights reserved.
//

import UIKit

class OuroborosView: UIView {
    
    var images: [String]! {
        didSet {
            self.setupScrollView()
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = false
        scrollView.bounces = true
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupSubviews()
    }
    
    func setupSubviews() {
        addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [scrollView.topAnchor.constraint(equalTo: self.topAnchor),
             scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
             scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             scrollView.rightAnchor.constraint(equalTo: self.rightAnchor)])
        
//        setupScrollView()
    }
    
    func setupScrollView() {
        scrollView.delegate = self
        
        for index in 0 ... images.count + 1 {
            let imageView = UIImageView(frame: CGRect(x: self.frame.width * CGFloat(index), y: 0, width: self.frame.width, height: self.frame.height))
            var imageStr = String()
            switch index {
            case 0:
                imageStr = images[images.count - 1]
            case images.count + 1:
                imageStr = images[0]
            default:
                imageStr = images[index - 1]
            }
            imageView.image = UIImage(named: imageStr)
            imageView.contentMode = .scaleToFill
            imageView.clipsToBounds = true
            imageView.isUserInteractionEnabled = true
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: self.frame.width * CGFloat(images.count + 2), height: self.frame.height)
        scrollView.contentOffset = CGPoint(x: self.frame.width, y: 0)
        
        self.startTimer()
    }
    
    var timer: Timer?
    var i = 1
    private func startTimer() {
        if timer != nil {
            self.stopTimer()
        }
        timer = Timer(timeInterval: 2, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .default)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func autoScroll() {
        if i == images.count + 1 {
            i = 1
        } else {
            i += 1
        }
        
        scrollView.setContentOffset(CGPoint(x: self.frame.width * CGFloat(i), y: 0), animated: true)
    }
}

extension OuroborosView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let contentOffsetX = scrollView.contentOffset.x
            
            if contentOffsetX == 0 {
                scrollView.contentOffset = CGPoint(x: self.frame.width * CGFloat(self.images.count), y: 0)
            }
            if contentOffsetX == CGFloat(self.images.count + 1) * self.frame.width {
                scrollView.contentOffset = CGPoint(x: self.frame.width, y: 0)
            }
//            let index = scrollView.contentOffset.x / self.frame.width - 0.5
            
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.startTimer()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.stopTimer()
    }
}
