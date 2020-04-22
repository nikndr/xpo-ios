//
//  ARViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 15.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import ARKit
import SceneKit
import UIKit

struct SCNResources {
    static let rootAssets = "art.scnassets"
    static let basicSceneName = "Scene"
    static let sceneExtension = ".scn"
    
    static let basicScenePath = fullPath(for: SCNResources.basicSceneName)
    
    static func fullPath(for resource: String, with fileExtension: String? = SCNResources.sceneExtension) -> String {
        return "\(SCNResources.rootAssets)/\(resource)\(fileExtension ?? "")"
    }
}

class ARViewController: UIViewController {
    // MARK: - Properties
    
    var expo: Expo!
    
    // MARK: - Outlets
    
    @IBOutlet var sceneView: ARSCNView!
    
    // MARK: - Actions
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        preloadModelDummies()
        
        sceneView.delegate = self
        
        let scene = SCNScene(named: "art.scnassets/Scene.scn")!
        
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        
        guard let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "ARRes", bundle: Bundle.main) else {
            debugPrint("no reference images found")
            return
        }
        
        configuration.trackingImages = trackingImages
        
        sceneView.session.run(configuration)
    }
    
    // MARK: - UI configuration
    
    /// Put your custom UI code here:
    /// rounded corners, shadows, corders etc.
    func configureUIElements() {
        navigationItem.title = expo.name
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    
    // MARK: - Additional setup
    
    func preloadModelDummies() {
        let models = [ARModel(id: 0, markerURL: "", modelURL: "", expoID: 0, createdAt: Date(), updatedAt: Date(), markerFilePath: "black", modelFilePath: SCNResources.fullPath(for: "cats/black-cat")),
                      ARModel(id: 0, markerURL: "", modelURL: "", expoID: 0, createdAt: Date(), updatedAt: Date(), markerFilePath: "red", modelFilePath: SCNResources.fullPath(for: "cats/red-tabby-cat")),
                      ARModel(id: 0, markerURL: "", modelURL: "", expoID: 0, createdAt: Date(), updatedAt: Date(), markerFilePath: "gray", modelFilePath: SCNResources.fullPath(for: "cats/gray-cat")),
                      ARModel(id: 0, markerURL: "", modelURL: "", expoID: 0, createdAt: Date(), updatedAt: Date(), markerFilePath: "light", modelFilePath: SCNResources.fullPath(for: "cats/gray-tabby-cat"))]
        expo.arModels += models
    }
}

extension ARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        guard
            let anchor = anchor as? ARImageAnchor,
            let modelNode = createModel(for: anchor.referenceImage)
        else { return nil }
        
        let overlayPlane = SCNPlane(width: anchor.referenceImage.physicalSize.width,
                                    height: anchor.referenceImage.physicalSize.height)
        overlayPlane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.7)
        let markerNode = SCNNode(geometry: overlayPlane)
        markerNode.eulerAngles.x = -.pi / 2
        
        node.addChildNode(markerNode)
        node.addChildNode(modelNode)
        
        return node
    }
    
    func createModel(for reference: ARReferenceImage) -> SCNNode? {
        guard
            let sceneName = sceneName(for: reference),
            let modelScene = SCNScene(named: sceneName),
            let modelNode = modelScene.rootNode.childNodes.first
        else { return nil }
        
        modelNode.position = SCNVector3Zero
        return modelNode
    }
    
    func sceneName(for reference: ARReferenceImage) -> String? {
        expo.arModels.filter { $0.markerFilePath == reference.name }.first?.modelFilePath
    }
}
