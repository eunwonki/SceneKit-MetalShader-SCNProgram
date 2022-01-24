import SceneKit
import MetalKit

class VolumeRenderingMaterial: SCNMaterial {
    
    init(view: SCNView) {
        super.init()
        
        program = SCNProgram()

        program?.vertexFunctionName = "textureSamplerVertex"
        program?.fragmentFunctionName = "textureSamplerFragment"
        
        let filePath = Bundle.main.url(forResource: "box", withExtension: "jpeg")!
        let textureLoader = MTKTextureLoader(device: view.device!)
        let options: [MTKTextureLoader.Option: Any] = [
            .generateMipmaps: true,
            .SRGB: true,
        ]
        let texture: MTLTexture
            = try! textureLoader.newTexture(URL: filePath,
                                            options: options)
        let imageProperty = SCNMaterialProperty(contents: texture)
        setValue(imageProperty, forKey: "boxTexture")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
