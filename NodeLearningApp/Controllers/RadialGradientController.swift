//
//  RadialGradientController.swift
//  NodeLearningApp
//
//  Created by Faraz on 23/02/20.
//  Copyright © 2020 Faraz. All rights reserved.
//

import UIKit

struct RadialColors {
    
    var light: UIColor!
    var dark: UIColor!
    
    init(light: String, dark: String) {
        self.light = UIColor(named: light)
        self.dark = UIColor(named: dark)
    }
}

class RadialGradientController: UIViewController {
    
    @IBOutlet weak var tableView: UIView!
    
    let colorsSource: [RadialColors] = [
        RadialColors(light: "#034F8D", dark: "#09457D"),
        RadialColors(light: "#AE275F", dark: "#762852"),
        RadialColors(light: "#E77817", dark: "#E15E23"),
        RadialColors(light: "#346CB7", dark: "#305CA6"),
        RadialColors(light: "#043F91", dark: "#0A3579"),
        RadialColors(light: "#E31E25", dark: "#B1151A"),
    ]

}

extension RadialGradientController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RadialViewCell") as! RadialViewCell
        let color = colorsSource[indexPath.row]
        cell.addGradient(color.light, darkColor: color.dark)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
