//
//  BBSceneCoordinator.swift
//  bumperBallsTv
//
//  Created by Davis Gossage on 10/4/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import UIKit
import GameController
import SceneKit

class BBSceneCoordinator: NSObject, BBControllerInputDelegate {
    static let sharedInstance = BBSceneCoordinator()
    
    ///game active?
    private var gameActive = false
    
    //BBSceneCoordinator is the parent, handles all other coordinators
    private let controllerCoordinator = BBControllerCoordinator()
    private let playerCoordinator = BBPlayerCoordinator()
    
    /// The mapping of controllers to players
    private var controllerMap : [GCController:BBPlayer] = [:]
    
    override init() {
        super.init()
        controllerCoordinator.inputDelegate = self
    }
    
    func attachScene(sceneView : SCNView!){
        sceneView.delegate = playerCoordinator
    }
    
    func getControllers() -> [GCController] {
        return controllerCoordinator.pairedControllers
    }
    
    func setControllerDelegate(delegateTarget : BBControllerDelegate) {
        controllerCoordinator.delegate = delegateTarget
    }
    
    func beginGame() {
        gameActive = true
        let players = playerCoordinator.createPlayers(controllerCoordinator.pairedControllers.count)
        for i in 0 ..< players.count{
            scene.rootNode.addChildNode(players[i])
            let controller = controllerCoordinator.pairedControllers[i]
            controllerMap[controller] = players[i]
        }
    }
    
    
    // MARK: BBControllerInputDelegate
    
    func inputReceivedFromController(controller: GCController, xValue: Float, yValue: Float) {
        if (gameActive){
            let player = controllerMap[controller]
            player?.xForceApplied = xValue
            player?.yForceApplied = yValue
        }
    }
}
