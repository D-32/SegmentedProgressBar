//
//  ViewController.swift
//  SegmentedProgressBar
//
//  Created by Dylan Marriott on 04.03.17.
//  Copyright © 2017 Dylan Marriott. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SegmentedProgressBarDelegate {

    private var spb: SegmentedProgressBar!
    private let iv = UIImageView()
    private let images = [#imageLiteral(resourceName: "img1"), #imageLiteral(resourceName: "img2"), #imageLiteral(resourceName: "img3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        iv.frame = view.bounds
        iv.contentMode = .scaleAspectFill
        view.addSubview(iv)
        updateImage(index: 0)
        
        
        spb = SegmentedProgressBar(numberOfSegments: 3, duration: 5)
        spb.frame = CGRect(x: 15, y: 15, width: view.frame.width - 30, height: 4)
        spb.delegate = self
        spb.topColor = UIColor.white
        spb.bottomColor = UIColor.white.withAlphaComponent(0.25)
        spb.padding = 2
        view.addSubview(spb)

        spb.startAnimation()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedView)))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func segmentedProgressBarChangedIndex(index: Int) {
        print("Now showing index: \(index)")
        updateImage(index: index)
    }
    
    func segmentedProgressBarFinished() {
        print("Finished!")
    }
    
    @objc private func tappedView() {
        spb.isPaused = !spb.isPaused
    }
    
    private func updateImage(index: Int) {
        iv.image = images[index]
    }
}

