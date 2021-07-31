//
//  ViewController.swift
//  TabBar
//
//  Created by Jingyu Lim on 2021/07/23.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        let vc4 = UIViewController()
        
        
        

        vc1.tabBarItem = UITabBarItem(title: "Red", image: UIImage(systemName: "moon"), tag: 1)
        vc1.view.backgroundColor = .systemRed
        vc2.tabBarItem = UITabBarItem(title: "Green", image: UIImage(systemName: "tray"), tag: 2)
        vc2.view.backgroundColor = .systemGreen
        vc3.tabBarItem = UITabBarItem(title: "Blue", image: UIImage(systemName: "xmark"), tag: 3)
        vc3.view.backgroundColor = .systemBlue
        vc4.tabBarItem = UITabBarItem(title: "Gray", image: UIImage(systemName: "doc"), tag: 4)
        vc4.view.backgroundColor = .systemGray

        viewControllers = [vc1, vc2, vc3, vc4]
        setViewControllers(viewControllers, animated: false)

    }


}

