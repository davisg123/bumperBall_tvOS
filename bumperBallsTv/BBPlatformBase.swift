//
//  BBPlatformBase.swift
//  bumperBallsTv
//
//  Created by Davis Gossage on 10/3/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import UIKit
import SceneKit

let INITIAL_RADIUS : CGFloat = 7.0
let INITIAL_HEIGHT : CGFloat = 10.0

class BBPlatformBase: SCNNode {
    
    override init() {
        super.init()
        self.geometry = SCNCylinder.init(radius: INITIAL_RADIUS, height: INITIAL_HEIGHT)
        self.physicsBody = SCNPhysicsBody.init(type: SCNPhysicsBodyType.Static, shape: SCNPhysicsShape.init(geometry: self.geometry!, options: nil))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
