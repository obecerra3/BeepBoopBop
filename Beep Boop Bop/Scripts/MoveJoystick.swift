//
//  MoveJoystick.swift
//  Beep Boop Bop
//
//  Created by Oscar Becerra on 11/4/17.
//  Copyright © 2017 Oscar Becerra. All rights reserved.
//

import SpriteKit

class MoveJoystick: AnalogJoystick {
    
    let dataX = DataBank()
    var width = CGFloat()
    var height = CGFloat()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        let substrateX = AnalogJoystickSubstrate(diameter: 100, color: .clear, image: UIImage(named: "jSubstrate"))
        let stickX = AnalogJoystickStick(diameter: 20, color: .clear, image: UIImage(named: "jStick"))
        super.init(substrate: substrateX , stick: stickX)
        
        width = CGFloat(dataX.defaults.float(forKey: "width"))
        height = CGFloat(dataX.defaults.float(forKey: "height"))
        
        
        self.substrate.diameter = width * 0.15
        self.stick.diameter = width * 0.1
        self.position = CGPoint(x: width * -0.37 , y: height * -0.29)
    }
    
    
    
}
