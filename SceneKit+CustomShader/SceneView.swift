import SwiftUI
import MetalKit
import SceneKit

struct SceneView: UIViewRepresentable
{
    typealias UIViewType = SCNView
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        let scene = SCNScene()
        let root = scene.rootNode
        
        view.backgroundColor = .lightGray
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.showsStatistics = true
        
        let otherbox2 = SCNBox(width: 1, height: 1,
                               length: 1, chamferRadius: 0)
        otherbox2.firstMaterial?.diffuse.contents = UIColor.yellow
        otherbox2.firstMaterial?.transparencyMode = .singleLayer
        otherbox2.firstMaterial?.transparency = 0.5
        let otherboxNode2 = SCNNode(geometry: otherbox2)
        otherboxNode2.position = SCNVector3Make(2, 0, 0)
        root.addChildNode(otherboxNode2)
        
        let box = SCNBox(width: 1, height: 1,
                         length: 1, chamferRadius: 0)
        box.firstMaterial = VolumeRenderingMaterial(view: view)
        
        let cube = SCNNode(geometry: box)
        root.addChildNode(cube)
        
        view.defaultCameraController.target = cube.geometry!.boundingSphere.center
        
        view.scene = scene
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
}
