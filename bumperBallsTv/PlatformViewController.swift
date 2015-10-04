//
//  PlatformViewController.swift
//  bumperBallsTv
//
//  Created by Davis Gossage on 10/3/15.
//  Copyright © 2015 Davis Gossage. All rights reserved.
//

import UIKit
import SceneKit
import GameController

var scene : SCNScene = SCNScene()

class PlatformViewController: UIViewController, BBControllerDelegate {
    
    private let sceneCoordinator = BBSceneCoordinator.sharedInstance
    
    @IBOutlet weak var scnView : SCNView!
    @IBOutlet weak var blurOverlay : UIView!
    @IBOutlet weak var numControllers : UILabel!
    @IBOutlet weak var startGameButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial scene attachment for rendering
        sceneCoordinator.attachScene(scnView)
        
        // become controller delegate
        sceneCoordinator.setControllerDelegate(self)
        
        // add our platform camera to the scene
        scene.rootNode.addChildNode(BBPlatformCamera())
        
        // create and add a generic light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        //base platform
        scene.rootNode.addChildNode(BBPlatformBase())
        
        // set the scene to the view
        scnView.scene = scene
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.blackColor()

    }
    
    func pairedControllerListDidUpdate(pairedControllers: [GCController]) {
        numControllers.text! = String(format:"%d Found", pairedControllers.count)
        startGameButton.enabled = pairedControllers.count > 0
    }
    
    @IBAction func startGame() {
        blurOverlay.hidden = true;
        sceneCoordinator.beginGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
