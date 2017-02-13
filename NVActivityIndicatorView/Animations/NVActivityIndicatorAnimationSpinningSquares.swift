//
//  NVActivityIndicatorAnimationAudioEqualizer.swift
//  NVActivityIndicatorViewDemo
//
// The MIT License (MIT)

// Copyright (c) 2016 Vinh Nguyen

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

class NVActivityIndicatorAnimationSpinningSquares: NVActivityIndicatorAnimationDelegate {
    
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        
        let squareWidth = size.width / 5
        let deltaX = size.width/5
        let deltaY = deltaX
        
        let centerX:CGFloat = size.width/2
        let centerY:CGFloat = size.height/2
        
        let duration: CFTimeInterval = 1
        
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        
        let squareTopLeft = NVActivityIndicatorShape.rectangle.layerWith(size: CGSize(width: squareWidth, height: squareWidth), color: color)
        squareTopLeft.frame = CGRect(x: centerX+1-squareWidth,
                                      y: centerY+1-squareWidth,
                                      width: squareWidth,
                                      height: squareWidth)

        let squareBottomLeft = NVActivityIndicatorShape.rectangle.layerWith(size: CGSize(width: squareWidth, height: squareWidth), color: color)
        squareBottomLeft.frame = CGRect(x: centerX+1-squareWidth,
                                     y: centerY,
                                     width: squareWidth,
                                     height: squareWidth)

        let squareBottomRight = NVActivityIndicatorShape.rectangle.layerWith(size: CGSize(width: squareWidth, height: squareWidth), color: color)
        squareBottomRight.frame = CGRect(x: centerX,
                                         y: centerY,
                                         width: squareWidth,
                                         height: squareWidth)

        let squareTopRight = NVActivityIndicatorShape.rectangle.layerWith(size: CGSize(width: squareWidth, height: squareWidth), color: color)
        squareTopRight.frame = CGRect(x: centerX,
                                     y: centerY+1-squareWidth,
                                     width: squareWidth,
                                     height: squareWidth)

        // Translate animation
        let translateAnimationTL = CAKeyframeAnimation(keyPath: "transform.translation")
        translateAnimationTL.keyTimes = [0, 0.5, 1]
        translateAnimationTL.timingFunctions = [timingFunction, timingFunction]
        translateAnimationTL.values = [
            NSValue(cgSize: CGSize(width: 0, height: 0)),
            NSValue(cgSize: CGSize(width: -deltaX, height: -deltaY)),
            NSValue(cgSize: CGSize(width: 0, height: 0))
        ]
        translateAnimationTL.duration = duration

        
        let translateAnimationBL = CAKeyframeAnimation(keyPath: "transform.translation")
        translateAnimationBL.keyTimes = [0, 0.5, 1]
        translateAnimationBL.timingFunctions = [timingFunction, timingFunction]
        translateAnimationBL.values = [
            NSValue(cgSize: CGSize(width: 0, height: 0)),
            NSValue(cgSize: CGSize(width: -deltaX, height: +deltaY)),
            NSValue(cgSize: CGSize(width: 0, height: 0))
        ]
        translateAnimationBL.duration = duration
        
        
        let translateAnimationBR = CAKeyframeAnimation(keyPath: "transform.translation")
        translateAnimationBR.keyTimes = [0, 0.5, 1]
        translateAnimationBR.timingFunctions = [timingFunction, timingFunction]
        translateAnimationBR.values = [
            NSValue(cgSize: CGSize(width: 0, height: 0)),
            NSValue(cgSize: CGSize(width: deltaX, height: deltaY)),
            NSValue(cgSize: CGSize(width: 0, height: 0))
        ]
        translateAnimationBR.duration = duration

        let translateAnimationTR = CAKeyframeAnimation(keyPath: "transform.translation")
        translateAnimationTR.keyTimes = [0, 0.5, 1]
        translateAnimationTR.timingFunctions = [timingFunction, timingFunction]
        translateAnimationTR.values = [
            NSValue(cgSize: CGSize(width: 0, height: 0)),
            NSValue(cgSize: CGSize(width: deltaX, height: -deltaY)),
            NSValue(cgSize: CGSize(width: 0, height: 0))
        ]
        translateAnimationTR.duration = duration

        
        // Rotate animation
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.keyTimes = [0, 0.2, 1]
        rotateAnimation.timingFunctions = [timingFunction, timingFunction]
        rotateAnimation.values = [0, 0, CGFloat(-M_PI_2)]
        rotateAnimation.duration = duration

        // Rotate animation
        let rotateAnimation2 = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnimation2.keyTimes = rotateAnimation.keyTimes
        rotateAnimation2.timingFunctions = [timingFunction, timingFunction]
        rotateAnimation2.values = [0, 0, CGFloat(M_PI_2)]
        rotateAnimation2.duration = duration

        
        // Animation
        let animationTL = CAAnimationGroup()
        animationTL.animations = [translateAnimationTL, rotateAnimation2]
        animationTL.duration = duration * 1.2
        animationTL.repeatCount = HUGE
        animationTL.isRemovedOnCompletion = false

        let animationBL = CAAnimationGroup()
        animationBL.animations = [translateAnimationBL, rotateAnimation]
        animationBL.duration = animationTL.duration
        animationBL.repeatCount = HUGE
        animationBL.isRemovedOnCompletion = false
        
        let animationTR = CAAnimationGroup()
        animationTR.animations = [translateAnimationTR, rotateAnimation]
        animationTR.duration = animationTL.duration
        animationTR.repeatCount = HUGE
        animationTR.isRemovedOnCompletion = false


        let animationBR = CAAnimationGroup()
        animationBR.animations = [translateAnimationBR, rotateAnimation2]
        animationBR.duration = animationTL.duration
        animationBR.repeatCount = HUGE
        animationBR.isRemovedOnCompletion = false


        squareTopLeft.add(animationTL, forKey: "animation")
        layer.addSublayer(squareTopLeft)

        squareBottomRight.add(animationBR, forKey: "animation")
        layer.addSublayer(squareBottomRight)

        squareBottomLeft.add(animationBL, forKey: "animation")
        layer.addSublayer(squareBottomLeft)

        squareTopRight.add(animationTR, forKey: "animation")
        layer.addSublayer(squareTopRight)

        
        let rotation = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 0, 1.0)
        layer.transform = CATransform3DTranslate(rotation, 0, 0, 0)
    }
}
