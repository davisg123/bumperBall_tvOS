//
//  BBPlayer.swift
//  bumperBallsTv
//
//  Created by Davis Gossage on 10/3/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import UIKit
import SceneKit


class BBPlayer: SCNNode {
    let INITIAL_RADIUS : CGFloat = 1.1
    
    var xForceApplied : Float = 0.0;
    var yForceApplied : Float = 0.0;
    
    init(position : SCNVector3) {
        super.init()
        let ball = SCNSphere.init(radius: INITIAL_RADIUS)
        self.position = position
        self.geometry = ball
        self.physicsBody = SCNPhysicsBody.init(type: SCNPhysicsBodyType.Dynamic, shape: SCNPhysicsShape.init(geometry: ball, options: nil))
        self.physicsBody?.restitution = 1.0
        self.geometry?.materials = [SCNMaterial()]
    }
    
    func setColor(){
        self.geometry!.materials[0].diffuse.contents = UIColor.blueColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
