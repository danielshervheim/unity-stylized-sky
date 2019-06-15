// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Stylized/Sky"
{
	Properties
	{
		[Header(Sun Disc)]_SunDiscColor("Sun Disc Color", Color) = (1,1,1,1)
		_SunDiscMultiplier("Sun Disc Multiplier", Float) = 100000
		_SunDiscExponent("Sun Disc Exponent", Float) = 100000
		[Header(Sun Halo)]_SunHaloColor("Sun Halo Color", Color) = (1,0,0,1)
		_SunHaloExponent("Sun Halo Exponent", Float) = 500
		_SunHaloContribution("Sun Halo Contribution", Range( 0 , 1)) = 1
		[Header(Horizon Line)]_HorizonLineColor("Horizon Line Color", Color) = (0,0,0,0)
		_HorizonLineExponent("Horizon Line Exponent", Float) = 1
		_HorizonLineContribution("Horizon Line Contribution", Range( 0 , 1)) = 1
		[Header(Sky Gradient)]_SkyGradientTop("Sky Gradient Top", Color) = (0,0,0,0)
		_SkyGradientBottom("Sky Gradient Bottom", Color) = (0,0,0,0)
		_SkyGradientExponent("Sky Gradient Exponent", Float) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Background"  "Queue" = "Background+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noinstancing noambient nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float3 worldPos;
		};

		uniform half _SunHaloExponent;
		uniform half4 _SunHaloColor;
		uniform half _SunHaloContribution;
		uniform half4 _SkyGradientTop;
		uniform half4 _SkyGradientBottom;
		uniform half _SkyGradientExponent;
		uniform half _HorizonLineExponent;
		uniform half4 _HorizonLineColor;
		uniform half _HorizonLineContribution;
		uniform half4 _SunDiscColor;
		uniform half _SunDiscMultiplier;
		uniform half _SunDiscExponent;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			half3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult31 = normalize( ase_worldViewDir );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 normalizeResult30 = normalize( -ase_worldlightDir );
			float dotResult35 = dot( normalizeResult31 , normalizeResult30 );
			float mask_sunDirection62 = dotResult35;
			float dotResult32 = dot( half3(0,-1,0) , normalizeResult31 );
			float mask_horizon58 = dotResult32;
			float4 color_sunHalo49 = ( saturate( ( pow( saturate( mask_sunDirection62 ) , ( saturate( abs( mask_horizon58 ) ) * _SunHaloExponent ) ) * ( 1.0 - saturate( pow( ( 1.0 - saturate( mask_horizon58 ) ) , 50.0 ) ) ) ) ) * _SunHaloColor * _SunHaloContribution );
			float4 lerpResult118 = lerp( _SkyGradientTop , _SkyGradientBottom , saturate( pow( ( 1.0 - saturate( mask_horizon58 ) ) , _SkyGradientExponent ) ));
			float4 color_skyGradient121 = lerpResult118;
			float3 lerpResult212 = lerp( float3( 0,0,0 ) , ( saturate( pow( ( 1.0 - abs( mask_horizon58 ) ) , _HorizonLineExponent ) ) * (_HorizonLineColor).rgb ) , _HorizonLineContribution);
			float3 color_horizonLine157 = lerpResult212;
			float mask_sunDisc214 = saturate( ( _SunDiscMultiplier * saturate( pow( saturate( mask_sunDirection62 ) , _SunDiscExponent ) ) ) );
			float4 lerpResult245 = lerp( saturate( ( color_sunHalo49 + color_skyGradient121 + half4( color_horizonLine157 , 0.0 ) ) ) , _SunDiscColor , mask_sunDisc214);
			o.Emission = lerpResult245.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Skybox/Procedural"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
202;73;1322;653;7008.741;348.821;5.882541;True;False
Node;AmplifyShaderEditor.CommentaryNode;64;-4428.017,1134.261;Float;False;1178.078;552.1107;;10;28;31;32;27;58;29;41;30;35;62;Common masks;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;28;-4133.94,1346.42;Float;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;27;-3982.048,1184.261;Float;False;Constant;_Horizonline;Horizon line;5;0;Create;True;0;0;False;0;0,-1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;31;-3971.28,1351.067;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;244;-2907.017,766.825;Float;False;1995.095;729.3989;;8;240;239;242;241;207;243;56;49;Sun Halo;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;32;-3768.019,1249.981;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;29;-4378.016,1507.372;Float;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;240;-2857.017,1196.344;Float;False;1135.106;254.1638;Horizon Soften;7;235;236;234;191;233;232;231;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;58;-3618.51,1244.758;Float;False;mask_horizon;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;41;-4150.859,1507.372;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;239;-2739.125,816.825;Float;False;1014.992;349.1858;Bell Curve;8;227;229;38;226;228;224;225;223;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;30;-4014.047,1506.423;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;236;-2807.017,1246.344;Float;False;58;mask_horizon;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;179;-2912.2,1670.741;Float;False;1523.875;386.7999;;12;157;196;156;152;150;151;149;178;148;211;212;213;Horizon Line;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;35;-3759.599,1421.607;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;235;-2585.146,1250.136;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;229;-2689.125,972.04;Float;False;58;mask_horizon;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;123;-2904.066,2262.316;Float;False;1370.266;540.5068;;10;121;118;119;120;117;114;222;115;220;112;Sky Gradient;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;148;-2862.2,1720.741;Float;False;58;mask_horizon;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;-3612.784,1417.461;Float;False;mask_sunDirection;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;228;-2455.234,976.1802;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-2523.983,1335.507;Float;False;Constant;_horizonSoftenExponent;horizonSoftenExponent;15;0;Create;True;0;0;False;0;50;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;234;-2434.579,1250.133;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;233;-2251.396,1278.95;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;227;-2307.796,976.6104;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-2379.464,1051.011;Float;False;Property;_SunHaloExponent;Sun Halo Exponent;4;0;Create;True;0;0;False;0;500;100;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;225;-2397.168,866.8252;Float;False;62;mask_sunDirection;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;178;-2653.359,1726.7;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;112;-2869.759,2617.055;Float;False;58;mask_horizon;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;226;-2135.177,1001.085;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;151;-2606.572,1806.839;Float;False;Property;_HorizonLineExponent;Horizon Line Exponent;7;0;Create;True;0;0;False;0;1;3.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;232;-2099.302,1279.329;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;224;-2144.728,871.0957;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;149;-2520.529,1727.244;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;220;-2658.22,2621.938;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;104;-2906.735,288.6479;Float;False;1272.782;300.1883;;9;214;103;101;70;102;68;69;82;66;Sun Disc;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;231;-1908.911,1280.088;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;223;-1904.134,926.9697;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;-2875.031,405.3662;Float;False;62;mask_sunDirection;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;150;-2312.992,1754.817;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;156;-2379.89,1886.407;Float;False;Property;_HorizonLineColor;Horizon Line Color;6;0;Create;True;0;0;False;1;Header(Horizon Line);0,0,0,0;0.2573529,0.2535944,0.2232915,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;222;-2512.968,2621.938;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-2603.295,2714.418;Float;False;Property;_SkyGradientExponent;Sky Gradient Exponent;11;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;211;-2160.587,1884.976;Float;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-2733.174,482.4931;Float;False;Property;_SunDiscExponent;Sun Disc Exponent;2;0;Create;True;0;0;False;0;100000;500000;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;82;-2659.179,409.9634;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;242;-1650.631,1104.842;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;114;-2347.537,2663.453;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;152;-2144.637,1752.6;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;68;-2501.426,432.7109;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;207;-1628.226,1381.222;Float;False;Property;_SunHaloContribution;Sun Halo Contribution;5;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;56;-1561.122,1204.905;Float;False;Property;_SunHaloColor;Sun Halo Color;3;0;Create;True;0;0;False;1;Header(Sun Halo);1,0,0,1;0.9811321,0.9617689,0.9117123,0.566;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;241;-1503.041,1104.324;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;120;-2276.106,2491.756;Float;False;Property;_SkyGradientBottom;Sky Gradient Bottom;10;0;Create;True;0;0;False;0;0,0,0,0;0.7980598,0.8688424,0.9245283,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;196;-1963.857,1804.07;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;213;-2097.114,1961.367;Float;False;Property;_HorizonLineContribution;Horizon Line Contribution;8;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;119;-2250.771,2317.268;Float;False;Property;_SkyGradientTop;Sky Gradient Top;9;0;Create;True;0;0;False;1;Header(Sky Gradient);0,0,0,0;0.07756317,0.4911062,0.7830188,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;117;-2189.226,2662.531;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;70;-2347.358,433.5449;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;102;-2420.064,345.1194;Float;False;Property;_SunDiscMultiplier;Sun Disc Multiplier;1;0;Create;True;0;0;False;0;100000;100000;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;212;-1793.428,1851.907;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;243;-1304.149,1187.823;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;118;-1963.591,2472.689;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;-1154.922,1182.917;Float;False;color_sunHalo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-2192.059,373.9016;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;157;-1628.725,1846.878;Float;False;color_horizonLine;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;-1797.338,2468.763;Float;False;color_skyGradient;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;202;-509.9169,765.9125;Float;False;869.2734;505.7511;;8;245;246;72;169;168;106;161;124;Putting it all togethor;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;-462.6157,910.6075;Float;False;121;color_skyGradient;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;103;-2046.841,373.7117;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;106;-434.8675,822.8812;Float;False;49;color_sunHalo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;161;-464.6684,996.0088;Float;False;157;color_horizonLine;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;214;-1892.897,370.6211;Float;False;mask_sunDisc;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;168;-194.8745,892.5608;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;246;-73.71066,1175.334;Float;False;214;mask_sunDisc;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;72;-62.3035,994.8154;Float;False;Property;_SunDiscColor;Sun Disc Color;0;0;Create;True;0;0;False;1;Header(Sun Disc);1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;169;0.2452037,892.5618;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;245;185.4055,976.0754;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;422.4861,928.0474;Half;False;True;2;Half;ASEMaterialInspector;0;0;Unlit;Stylized/Sky;False;False;False;False;True;False;True;True;True;True;True;True;False;False;True;True;False;True;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Background;;Background;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;Skybox/Procedural;12;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;31;0;28;0
WireConnection;32;0;27;0
WireConnection;32;1;31;0
WireConnection;58;0;32;0
WireConnection;41;0;29;0
WireConnection;30;0;41;0
WireConnection;35;0;31;0
WireConnection;35;1;30;0
WireConnection;235;0;236;0
WireConnection;62;0;35;0
WireConnection;228;0;229;0
WireConnection;234;0;235;0
WireConnection;233;0;234;0
WireConnection;233;1;191;0
WireConnection;227;0;228;0
WireConnection;178;0;148;0
WireConnection;226;0;227;0
WireConnection;226;1;38;0
WireConnection;232;0;233;0
WireConnection;224;0;225;0
WireConnection;149;0;178;0
WireConnection;220;0;112;0
WireConnection;231;0;232;0
WireConnection;223;0;224;0
WireConnection;223;1;226;0
WireConnection;150;0;149;0
WireConnection;150;1;151;0
WireConnection;222;0;220;0
WireConnection;211;0;156;0
WireConnection;82;0;66;0
WireConnection;242;0;223;0
WireConnection;242;1;231;0
WireConnection;114;0;222;0
WireConnection;114;1;115;0
WireConnection;152;0;150;0
WireConnection;68;0;82;0
WireConnection;68;1;69;0
WireConnection;241;0;242;0
WireConnection;196;0;152;0
WireConnection;196;1;211;0
WireConnection;117;0;114;0
WireConnection;70;0;68;0
WireConnection;212;1;196;0
WireConnection;212;2;213;0
WireConnection;243;0;241;0
WireConnection;243;1;56;0
WireConnection;243;2;207;0
WireConnection;118;0;119;0
WireConnection;118;1;120;0
WireConnection;118;2;117;0
WireConnection;49;0;243;0
WireConnection;101;0;102;0
WireConnection;101;1;70;0
WireConnection;157;0;212;0
WireConnection;121;0;118;0
WireConnection;103;0;101;0
WireConnection;214;0;103;0
WireConnection;168;0;106;0
WireConnection;168;1;124;0
WireConnection;168;2;161;0
WireConnection;169;0;168;0
WireConnection;245;0;169;0
WireConnection;245;1;72;0
WireConnection;245;2;246;0
WireConnection;0;2;245;0
ASEEND*/
//CHKSM=3A3F73FC5482D2D1D722BF375B9D672D2D6F96A6