//
//  ViewController.swift
//  SegmentedProgressBar
//
//  Created by Dylan Marriott on 04.03.17.
//  Copyright © 2017 Dylan Marriott. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SegmentedProgressBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let spb = SegmentedProgressBar(numberOfSegments: 2, duration: 5)
        spb.frame = CGRect(x: 15, y: 15, width: view.frame.width - 30, height: 4)
        spb.delegate = self
        // possible configs:
        //spb.topColor = UIColor.red
        //spb.bottomColor = UIColor.blue
        //spb.padding = 10
        view.addSubview(spb)

        spb.startAnimating()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    func segmentedProgressBarChangedIndex(index: Int) {
        print("Now showing index: \(index)")
    }
    
    func segmentedProgressBarFinished() {
        print("Finished!")
    }
}

