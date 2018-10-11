//
//  ViewController.swift
//  Cubes
//
//  Created by David E Bratton on 10/11/18.
//  Copyright © 2018 David Bratton. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var minHeight: CGFloat = 0.2
    var maxHeight: CGFloat = 0.6
    var minDispersal: CGFloat = -4
    var maxDispersal: CGFloat = 4
    
    func generateRandomVector() -> SCNVector3 {
        return SCNVector3(CGFloat.random(in: minDispersal ... maxDispersal),
                          CGFloat.random(in: minDispersal ... maxDispersal),
                          CGFloat.random(in: minDispersal ... maxDispersal))
    }
    
    func generateRandomColor() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0 ... 1),
                       green: CGFloat.random(in: 0 ... 1),
                       blue: CGFloat.random(in: 0 ... 1),
                       alpha: CGFloat.random(in: 0.5 ... 1))
    }
    
    func generateRandomeSize() -> CGFloat {
        return CGFloat.random(in: minHeight ... maxHeight)
    }
    
    func generateCube() {
        let s = generateRandomeSize()
        let cube = SCNBox(width: s, height: s, length: s, chamferRadius: 0.03)
        cube.materials.first?.diffuse.contents = generateRandomColor()
        
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = generateRandomVector()
        
        let rotateAction = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 3)
        let repeatAction = SCNAction.repeatForever(rotateAction)
        cubeNode.runAction(repeatAction)
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
        

    }
    
    @IBAction func addCubePressed(_ sender: Any) {
        generateCube()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

}
