//
//  RadialView.swift
//  NodeLearningApp
//
//  Created by Faraz on 23/02/20.
//  Copyright © 2020 Faraz. All rights reserved.
//

import UIKit

class RadialGradientLayer: CALayer {

    var center : CGPoint!
    var radius : CGFloat!
    var colors : [CGColor]!
    
   override init(){
        super.init()

        needsDisplayOnBoundsChange = true
    }
//
//     init(center:CGPoint,radius:CGFloat,colors:[CGColor]){
//
//        self.center = center
//        self.radius = radius
//        self.colors = colors
//
//        super.init()
//
//    }
    
    init(frame: CGRect, colors:[CGColor]) {
        self.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        self.radius = frame.width
        self.colors = colors
        
        super.init()
        
        self.needsDisplayOnBoundsChange = true
        self.frame = frame
    }

    required init(coder aDecoder: NSCoder) {

        super.init()

    }

    override func draw(in ctx: CGContext) {
        ctx.saveGState()

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0.0, 0.6])
        
        ctx.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: [])
    }

}
