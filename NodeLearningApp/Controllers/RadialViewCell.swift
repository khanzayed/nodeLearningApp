//
//  RadialViewCell.swift
//  NodeLearningApp
//
//  Created by Faraz on 27/02/20.
//  Copyright © 2020 Faraz. All rights reserved.
//

import UIKit

class RadialViewCell: UITableViewCell {

    @IBOutlet weak var viewWithGradient: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewWithGradient.layer.cornerRadius = 10
        viewWithGradient.layer.masksToBounds = true
    }
    
    internal func addGradient(_ lightColor: UIColor, darkColor: UIColor) {
        let colors = [lightColor.cgColor, darkColor.cgColor]
        let gl = RadialGradientLayer(frame: viewWithGradient.bounds, colors: colors)
        viewWithGradient.layer.addSublayer(gl)
        
        viewWithGradient.setNeedsDisplay()
    }

}
