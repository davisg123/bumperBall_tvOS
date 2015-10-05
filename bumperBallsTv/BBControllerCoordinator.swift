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

protocol BBControllerInputDelegate {
    func inputReceivedFromController(controller : GCController, xValue : Float, yValue : Float)
}

class BBControllerCoordinator: NSObject {
    /// The controllers that are paired to the device, not necessarily attached to a player
    var pairedControllers : [GCController] = []
    
    /// Delegate for paired controller updates
    var delegate: BBControllerDelegate?
    
    /// Delegate for controller input
    var inputDelegate: BBControllerInputDelegate?
    
    override init() {
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleControllerDidConnectNotification:", name: GCControllerDidConnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleControllerDidDisconnectNotification:", name: GCControllerDidDisconnectNotification, object: nil)
    }
    
    func registerControllerMovementHandler(controller : GCController){
        controller.microGamepad?.dpad.valueChangedHandler = { _, xValue, yValue in
            //i'd like to take this moment to say I love swift
            self.inputDelegate?.inputReceivedFromController(controller, xValue: xValue, yValue: yValue)
        }
    }
    
    func deregisterControllerMovementHandler(controller : GCController){
        //is this even necessary, it looks funny
        controller.microGamepad?.dpad.valueChangedHandler! = {_,_,_ in }
    }
    
    @objc func handleControllerDidConnectNotification(notification: NSNotification) {
        let controller = notification.object as! GCController
        registerControllerMovementHandler(controller)
        pairedControllers.append(controller)
        delegate?.pairedControllerListDidUpdate(pairedControllers)
    }
    
    @objc func handleControllerDidDisconnectNotification(notification: NSNotification) {
        let controller = notification.object as! GCController
        deregisterControllerMovementHandler(controller)
        pairedControllers.removeAtIndex(pairedControllers.indexOf(notification.object as! GCController)!)
        delegate?.pairedControllerListDidUpdate(pairedControllers)
    }
}
