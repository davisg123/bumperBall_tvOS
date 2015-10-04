//
//  BBControllerCoordinator.swift
//  bumperBallsTv
//
//  Created by Davis Gossage on 10/4/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import UIKit
import GameController

protocol BBControllerDelegate {
    func pairedControllerListDidUpdate(pairedControllers : [GCController])
}

class BBControllerCoordinator: NSObject {
    /// The controllers that are paired to the device, not necessarily attached to a player
    var pairedControllers : [GCController] = []
    
    /// Delegate for paired controller updates
    var delegate: BBControllerDelegate?
    
    override init() {
        super.init()
        
        /// Register for `GCGameController` pairing notifications.
        func registerForGameControllerNotifications() {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleControllerDidConnectNotification:", name: GCControllerDidConnectNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleControllerDidDisconnectNotification:", name: GCControllerDidDisconnectNotification, object: nil)
        }
    }
    
    @objc func handleControllerDidConnectNotification(notification: NSNotification) {
        pairedControllers.append(notification.object as! GCController)
        delegate?.pairedControllerListDidUpdate(pairedControllers)
    }
    
    @objc func handleControllerDidDisconnectNotification(notification: NSNotification) {
        pairedControllers.removeAtIndex(pairedControllers.indexOf(notification.object as! GCController)!)
        delegate?.pairedControllerListDidUpdate(pairedControllers)
    }
}
