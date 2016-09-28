//
//  Progressable.swift
//  Progressable
//
//  Created by Martin MOIZARD-LANVIN on 21/09/2016.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit
import CoreGraphics

public protocol Progressable: class {
    var progress: CGFloat { get set }
    var progressLineWidth: CGFloat { get set }
    var progressColor: UIColor? { get set }
    
    func initProgress()
    func layoutProgress()
    func setProgress(progress: CGFloat, withDuration duration: TimeInterval)
}

var progressAttr = "progressAttr"
var progressLineWidthAttr = "progressLineWidthAttr"
var progressLayerAttr = "progressLayerAttr"

extension Progressable where Self: UIView {
    public var progress: CGFloat {
        get {
            if let progress = objc_getAssociatedObject(self, &progressAttr) as? CGFloat {
                return progress
            } else {
                self.progress = 0.0
                return self.progress
            }
        }
        set {
            self.progressLayer.removeAllAnimations()
            objc_setAssociatedObject(self, &progressAttr, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.setNeedsLayout()
        }
    }
    
    public var progressLineWidth: CGFloat {
        get {
            if let progressLineWidth = objc_getAssociatedObject(self, &progressLineWidthAttr) as? CGFloat {
                return progressLineWidth
            } else {
                self.progressLineWidth = 1.0
                return self.progressLineWidth
            }
        }
        set {
            objc_setAssociatedObject(self, &progressLineWidthAttr, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.setNeedsLayout()
        }
    }
    
    public var progressColor: UIColor? {
        get {
            guard let color = self.progressLayer.backgroundColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            self.progressLayer.backgroundColor = newValue?.cgColor
        }
    }
    
    internal var progressLayer: CALayer {
        get {
            if let progressLayer = objc_getAssociatedObject(self, &progressLayerAttr) as? CALayer {
                return progressLayer
            } else {
                self.progressLayer = CALayer()
                self.progressLayer.anchorPoint = CGPoint.zero
                return self.progressLayer
            }
        }
        set {
            objc_setAssociatedObject(self, &progressLayerAttr, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    internal func frame(forProgress progress: CGFloat) -> CGRect {
        return CGRect(x: 0,
                      y: self.bounds.height - CGFloat(self.progressLineWidth),
                      width: (progress * self.bounds.width) / 100,
                      height: CGFloat(self.progressLineWidth))
    }
    
    public func initProgress() {
        self.layer.addSublayer(self.progressLayer)
    }
    
    public func layoutProgress() {
        disableImplicitAnimations {
            self.progressLayer.frame = self.frame(forProgress: self.progress)
        }
    }
    
    fileprivate func disableImplicitAnimations(updates: () -> ()) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        updates()
        CATransaction.commit()
    }
    
    public func setProgress(progress: CGFloat, withDuration duration: TimeInterval) {
        let progressLayer = self.progressLayer
        let toFrame = self.frame(forProgress: progress)
        let toBounds = CGRect(x: 0, y: 0,
                              width: toFrame.size.width,
                              height: toFrame.size.height)
        
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.fromValue = NSValue(cgRect: self.progressLayer.visibleBounds())
        animation.toValue = NSValue(cgRect: toBounds)
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        self.progress = progress
        progressLayer.frame = toFrame
        progressLayer.add(animation, forKey: "bounds")
    }
}

extension CALayer {
    fileprivate func visibleBounds() -> CGRect {
        if self.animation(forKey: "bounds") != nil {
            let currentLayer = self.presentation()
            return (currentLayer?.value(forKey: "bounds") as! NSValue).cgRectValue
        } else {
            return self.bounds
        }
    }
}
