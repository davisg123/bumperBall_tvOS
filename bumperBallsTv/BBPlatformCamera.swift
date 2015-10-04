//
//  BBPlatformCamera.swift
//  bumperBallsTv
//
//  Created by Davis Gossage on 10/3/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import UIKit
import SceneKit

let INITIAL_POSITION = SCNVector3(x: 0, y: 12, z: 12)
let INITIAL_ANGLE = SCNVector3Make(-0.65, 0, 0)


class BBPlatformCamera: SCNNode {
    
    override init() {
        super.init()
        self.camera = SCNCamera()
        self.position = INITIAL_POSITION
        self.eulerAngles = INITIAL_ANGLE
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
