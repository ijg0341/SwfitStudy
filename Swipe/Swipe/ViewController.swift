//
//  ViewController.swift
//  Swipe
//
//  Created by Jingyu Lim on 2021/07/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var upImageView: UIImageView!
    @IBOutlet weak var downImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    let colors:[UIColor] = [.systemBlue, .systemRed]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            upImageView.tintColor = colors[0]
            downImageView.tintColor = colors[0]
            leftImageView.tintColor = colors[0]
            rightImageView.tintColor = colors[0]
            
            switch swipeGesture.direction {
            case .up:
                upImageView.tintColor = colors[1]
            case .down:
                downImageView.tintColor = colors[1]
            case .left:
                leftImageView.tintColor = colors[1]
            case .right:
                rightImageView.tintColor = colors[1]
            default:
                break
            }
            
        }
    }

}

