Shader "DSS/Stylized/Sky"
{
    Properties
    {
        // Sun disc
        _SunDiscColor ("Color", Color) = (1, 1, 1, 1)
        _SunDiscExponent ("Falloff Exponent", float) = 125000
        _SunDiscMultiplier ("Sharpness Multiplier", float) = 25

        // Sun halo
        _SunHaloColor ("Color", Color) = (0.8970588, 0.7760561, 0.6661981, 1)
        _SunHaloContribution ("Contribution", Range(0, 1)) = 0.75
        _SunHaloExponent ("Falloff Exponent", float) = 125

        // Horizon line
        _HorizonLineColor ("Color", Color) = (0.9044118, 0.8872592, 0.7913603, 1)
        _HorizonLineContribution ("Contribution", Range(0, 1)) = 0.25
        _HorizonLineExponent ("Falloff Exponent", float) = 4
        
        // Sky gradient
        _SkyGradientTop ("Top", Color) = (0.172549, 0.5686274, 0.6941177, 1)
        _SkyGradientBottom ("Bottom", Color) = (0.764706, 0.8156863, 0.8509805)
        _SkyGradientExponent ("Falloff Exponent", float) = 2.5

        // Debug
        _DebugMode("DebugMode", int) = 0
    }
    SubShader
    {
        Tags
        {
            "RenderType" = "Background"
            "Queue" = "Background"
            "RenderPipeline" = "UniversalRenderPipeline"
        }
        Pass
        {
            HLSLPROGRAM

            #pragma vertex Vertex
            #pragma fragment Fragment

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.dss.stylized-sky/Runtime/Shaders/SkyCommon.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;                 
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float3 positionWS : TEXCOORD0;
            };            

            Varyings Vertex(Attributes attributes)
            {
                Varyings varyings;
                varyings.positionHCS = TransformObjectToHClip(attributes.positionOS.xyz);
                varyings.positionWS = TransformObjectToWorld(attributes.positionOS.xyz);
                return varyings;
            }

            half3 GetSunDirection()
            {
                Light mainLight = GetMainLight();
                return mainLight.direction;
            }

            half4 Fragment(Varyings varyings) : SV_Target
            {
                half3 viewDirWS = normalize(varyings.positionWS);
                half3 sunDirWS = normalize(GetSunDirection());
                half3 skyColor = ComputeSkyColor(viewDirWS, sunDirWS);
                return half4(skyColor, 1.0);
            }
    
            ENDHLSL
        }
    }
    CustomEditor "DSS.Stylized.Sky"
}