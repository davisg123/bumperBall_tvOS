//
//  BBPlayerCoordinator.swift
//  bumperBallsTv
//
//  Created by Davis Gossage on 10/5/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import UIKit
import SceneKit

class BBPlayerCoordinator: NSObject, SCNSceneRendererDelegate {
    let FORCE_SCALE_FACTOR : Float = 10.0
    
    private var players : [BBPlayer] = []
    
    var count = 0
    
    func createPlayers(numPlayers : Int) -> [BBPlayer]{
        players.removeAll()
        for pos in playerPositions(numPlayers){
            players.append(BBPlayer(position: pos))
        }
        return players;
    }
    
    private func playerPositions(numPlayers : Int) -> [SCNVector3]{
        switch numPlayers{
        case 1:
            return [SCNVector3Make(0, 20, 0)]
        case 2:
            return [SCNVector3Make(2.5, 20, 0), SCNVector3Make(-2.5, 20, 0)]
        case 3:
            return [SCNVector3Make(2.5, 20, 0), SCNVector3Make(0, 20, 0), SCNVector3Make(-2.5, 20, 0)]
        case 4:
            return [SCNVector3Make(2.5, 20, 0), SCNVector3Make(-2.5, 20, 0), SCNVector3Make(0, 20, 2.5), SCNVector3Make(0, 20, -2.5)]
        default:
            return [SCNVector3Make(0, 20, 0)]
        }
    }
    
    func renderer(renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: NSTimeInterval) {
        count++
        for player : BBPlayer in players{
            //we want reversing out of motion to be easier
            let sameSignX = (player.physicsBody!.velocity.x * player.xForceApplied) > 0
            let sameSignY = (player.physicsBody!.velocity.y * player.yForceApplied) > 0
            
            let reverseSpeedXFactor : Float = !sameSignX ? 2.0 : 1.0;
            let reverseSpeedYFactor : Float = !sameSignY ? 2.0 : 1.0;
            
            player.physicsBody!.applyForce(SCNVector3Make(player.xForceApplied*FORCE_SCALE_FACTOR*reverseSpeedXFactor, 0, -player.yForceApplied*FORCE_SCALE_FACTOR*reverseSpeedYFactor), impulse: false)
        }
    }
}
