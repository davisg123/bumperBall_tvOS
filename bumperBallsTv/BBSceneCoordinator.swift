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

class BBSceneCoordinator: NSObject {
    static let sharedInstance = BBSceneCoordinator()
    
    //BBSceneCoordinator is the parent, handles all other coordinators
    private let controllerCoordinator = BBControllerCoordinator()
    private let playerCoordinator = BBPlayerCoordinator()
    
    /// The mapping of controllers to players
    private var controllerMap = []
    
    override init() {
        super.init()
    }
    
    func attachScene(sceneView : SCNView!){
        sceneView.delegate = playerCoordinator
    }
    
    func getControllers() -> [GCController] {
        return controllerCoordinator.pairedControllers
    }
    
    func controllerDelegate() -> BBControllerDelegate {
        return controllerCoordinator.delegate!
    }
}
