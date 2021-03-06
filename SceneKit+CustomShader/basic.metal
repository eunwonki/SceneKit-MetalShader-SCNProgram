//
//  shader.metal
//  SceneKit+CustomShader
//
//  Created by skia on 2022/01/24.
//

#include <metal_stdlib>
using namespace metal;

#include <SceneKit/scn_metal>

struct NodeBuffer {
    float4x4 modelTransform;
    float4x4 modelViewProjectionTransform;
    float4x4 modelViewTransform;
    float4x4 normalTransform;
    float2x3 boundingBox;
};

struct VertexInput {
    float3 position  [[attribute(SCNVertexSemanticPosition)]];
    float3 normal   [[ attribute(SCNVertexSemanticNormal) ]];
    float4 color [[ attribute(SCNVertexSemanticColor) ]];
    float2 uv [[ attribute(SCNVertexSemanticTexcoord0) ]];
};

struct VertexOut {
    float4 position [[position]];
    float2 uv;
};

vertex VertexOut
textureSamplerVertex(
    VertexInput in [[ stage_in ]],
    constant NodeBuffer& scn_node [[buffer(1)]])
{
    VertexOut out;
    out.position = scn_node.modelViewProjectionTransform
    * float4(in.position, 1.0);
    out.uv = in.uv;
    return out;
}

fragment float4
textureSamplerFragment(
    VertexOut in [[ stage_in ]],
    texture2d<float, access::sample> boxTexture [[texture(0)]],
    constant NodeBuffer& node [[buffer(1)]]
)
{
    constexpr sampler textureSampler(coord::normalized,
                                     filter::linear,
                                     address::repeat);
    return boxTexture.sample(textureSampler, in.uv);
}




