Shader "DSS/Stylized/Sky"
{
    Properties
    {
        [Header(Sun Disc)]
        _SunDiscColor ("Color", Color) = (1, 1, 1, 1)
        _SunDiscExponent ("Falloff Exponent", float) = 125000
        _SunDiscMultiplier ("Sharpness Multiplier", float) = 25

        [Header(Sun Halo)]
        _SunHaloColor ("Color", Color) = (0.8970588, 0.7760561, 0.6661981, 1)
        _SunHaloContribution ("Contribution", Range(0, 1)) = 0.75
        _SunHaloExponent ("Falloff Exponent", float) = 125

        [Header(Horizon Line)]
        _HorizonLineColor ("Color", Color) = (0.9044118, 0.8872592, 0.7913603, 1)
        _HorizonLineContribution ("Contribution", Range(0, 1)) = 0.25
        _HorizonLineExponent ("Falloff Exponent", float) = 4
        
        [Header(Sky Gradient)]
        _SkyGradientTop ("Top", Color) = (0.172549, 0.5686274, 0.6941177, 1)
        _SkyGradientBottom ("Bottom", Color) = (0.764706, 0.8156863, 0.8509805)
        _SkyGradientExponent ("Falloff Exponent", float) = 2.5
    }
    SubShader
    {
        Tags
        {
            "RenderType" = "Background"
            "Queue" = "Background"
        }
        LOD 100

        Pass
        {
            HLSLPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "StylizedSkyCommon.hlsl"
            
            struct Attributes
            {
                float4 vertex : POSITION;
            };

            struct Varyings
            {
                float4 vertex : SV_POSITION;
                float3 worldPosition : TEXCOORD1;
            };

            Varyings vert (Attributes attribs)
            {
                Varyings vary;
                vary.vertex = UnityObjectToClipPos(attribs.vertex);
                vary.worldPosition = mul(unity_ObjectToWorld, attribs.vertex).xyz;
                return vary;
            }

            half4 frag (Varyings vary) : SV_Target
            {
                half3 viewDirWS = normalize(vary.worldPosition);
                half3 sunDirWS = normalize(_WorldSpaceLightPos0.xyz);

                return half4(ComputeColor(viewDirWS, sunDirWS), 1.0);
            }
            ENDHLSL
        }
    }
}
