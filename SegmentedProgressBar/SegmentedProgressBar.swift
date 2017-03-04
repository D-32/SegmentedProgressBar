//
//  SegmentedProgressBar.swift
//  SegmentedProgressBar
//
//  Created by Dylan Marriott on 04.03.17.
//  Copyright © 2017 Dylan Marriott. All rights reserved.
//

import Foundation
import UIKit

protocol SegmentedProgressBarDelegate: class {
    func segmentedProgressBarChangedIndex(index: Int)
    func segmentedProgressBarFinished()
}

class SegmentedProgressBar: UIView {
    
    weak var delegate: SegmentedProgressBarDelegate?
    
    private var segments = [Segment]()
    private let duration: TimeInterval
    private var hasDoneLayout = false // hacky way to prevent layouting again
    
    init(numberOfSegments: Int, duration: TimeInterval = 5.0) {
        self.duration = duration
        super.init(frame: CGRect.zero)
        
        for _ in 0..<numberOfSegments {
            let segment = Segment()
            addSubview(segment.bottomSegmentView)
            addSubview(segment.topSegmentView)
            segments.append(segment)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if hasDoneLayout {
            return
        }
        let padding: CGFloat = 2.0
        let width = (frame.width - (padding * CGFloat(segments.count - 1)) ) / CGFloat(segments.count)
        for (index, segment) in segments.enumerated() {
            let segFrame = CGRect(x: CGFloat(index) * (width + padding), y: 0, width: width, height: frame.height)
            segment.bottomSegmentView.frame = segFrame
            segment.topSegmentView.frame = segFrame
            segment.topSegmentView.frame.size.width = 0
        }
        hasDoneLayout = true
    }
    
    func startAnimating() {
        layoutSubviews()
        animate()
    }
    
    private func animate(animationIndex: Int = 0) {
        if animationIndex >= segments.count {
            // finished all animations
            delegate?.segmentedProgressBarFinished()
            return
        }
        let nextSegment = segments[animationIndex]
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: { 
            nextSegment.topSegmentView.frame.size.width = nextSegment.bottomSegmentView.frame.width
        }) { (finished) in
            let newIndex = animationIndex + 1
            self.delegate?.segmentedProgressBarChangedIndex(index: newIndex)
            self.animate(animationIndex: newIndex)
        }
    }
}

fileprivate class Segment {
    let bottomSegmentView = UIView()
    let topSegmentView = UIView()
    init() {
        bottomSegmentView.backgroundColor = UIColor.gray
        bottomSegmentView.alpha = 0.5
        bottomSegmentView.layer.cornerRadius = 2
        
        topSegmentView.backgroundColor = UIColor.red
        topSegmentView.layer.cornerRadius = 2
    }
}
