//
//  ViewController.swift
//  PageControl
//
//  Created by Jingyu Lim on 2021/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    let images = [ "1", "2", "3", "4", "5" ]
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        
    }
    
    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        imageView.image = UIImage(named: images[sender.currentPage])
    }
    
    func viewInit() {
        view.addSubview(imageView)
        view.addSubview(pageControl)
    
        let safeArea = view.safeAreaLayoutGuide
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        imageView.image = UIImage(named: images[0])
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        pageControl.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        pageControl.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        pageControl.rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .green
        pageControl.currentPageIndicatorTintColor = .red
    }


}

