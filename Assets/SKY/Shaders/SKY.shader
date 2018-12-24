// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "danielshervheim/STYLIZED/SKY"
{
	Properties
	{
		[MaterialTitle(SKY)]_Title("Title", Int) = 0
		[Header(Sun Disc)]_SunDiscContribution("Sun Disc Contribution", Range( 0 , 1)) = 1
		_SunDiscExponent("Sun Disc Exponent", Float) = 100000
		_SunDiscMultiplier("Sun Disc Multiplier", Float) = 100000
		_SunDiscColor("Sun Disc Color", Color) = (1,1,1,1)
		[Header(Sun Halo)]_SunHaloContribution("Sun Halo Contribution", Range( 0 , 1)) = 1
		_SunHaloExponent("Sun Halo Exponent", Float) = 500
		_SunHaloColor("Sun Halo Color", Color) = (1,0,0,1)
		[Header(Horizon Line)]_HorizonLineContribution("Horizon Line Contribution", Range( 0 , 1)) = 1
		_HorizonLineExponent("Horizon Line Exponent", Float) = 1
		_HorizonLineColor("Horizon Line Color", Color) = (0,0,0,0)
		[Header(Sky Gradient)]_SkyGradientExponent("Sky Gradient Exponent", Float) = 1
		_SkyGradientBottom("Sky Gradient Bottom", Color) = (0,0,0,0)
		_SkyGradientTop("Sky Gradient Top", Color) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Background"  "Queue" = "Background+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog 
		struct Input
		{
			float3 worldPos;
		};

		uniform int _Title;
		uniform half _SunDiscMultiplier;
		uniform half _SunDiscExponent;
		uniform half4 _SunDiscColor;
		uniform half _SunDiscContribution;
		uniform half _SunHaloExponent;
		uniform half4 _SunHaloColor;
		uniform half _SunHaloContribution;
		uniform half4 _SkyGradientBottom;
		uniform half4 _SkyGradientTop;
		uniform half _SkyGradientExponent;
		uniform half _HorizonLineExponent;
		uniform half4 _HorizonLineColor;
		uniform half _HorizonLineContribution;

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
			float mask_sun_dir62 = dotResult35;
			float temp_output_103_0 = saturate( ( _SunDiscMultiplier * saturate( pow( saturate( mask_sun_dir62 ) , _SunDiscExponent ) ) ) );
			float3 lerpResult209 = lerp( float3( 0,0,0 ) , ( temp_output_103_0 * (_SunDiscColor).rgb ) , _SunDiscContribution);
			float3 sun_disc73 = lerpResult209;
			float dotResult32 = dot( half3(0,-1,0) , normalizeResult31 );
			float mask_horizon58 = dotResult32;
			float temp_output_52_0 = ( 1.0 - saturate( mask_horizon58 ) );
			float3 lerpResult206 = lerp( float3( 0,0,0 ) , ( saturate( ( ( 1.0 - saturate( pow( temp_output_52_0 , 40.0 ) ) ) * saturate( ( temp_output_52_0 * pow( saturate( mask_sun_dir62 ) , ( saturate( mask_horizon58 ) * _SunHaloExponent ) ) ) ) ) ) * (_SunHaloColor).rgb ) , _SunHaloContribution);
			float3 sun_halo49 = lerpResult206;
			float4 lerpResult118 = lerp( _SkyGradientBottom , _SkyGradientTop , saturate( pow( abs( mask_horizon58 ) , _SkyGradientExponent ) ));
			float4 sky_gradient121 = lerpResult118;
			float3 lerpResult212 = lerp( float3( 0,0,0 ) , ( saturate( pow( ( 1.0 - abs( mask_horizon58 ) ) , _HorizonLineExponent ) ) * (_HorizonLineColor).rgb ) , _HorizonLineContribution);
			float3 horizon_line157 = lerpResult212;
			float mask_sundisk214 = temp_output_103_0;
			o.Emission = ( half4( sun_disc73 , 0.0 ) + ( saturate( ( saturate( ( half4( sun_halo49 , 0.0 ) + sky_gradient121 ) ) + half4( horizon_line157 , 0.0 ) ) ) * ( 1.0 - mask_sundisk214 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16103
202;92;1416;650;7027.958;445.5079;5.979714;True;False
Node;AmplifyShaderEditor.CommentaryNode;64;-4428.017,1134.261;Float;False;1178.078;552.1107;;10;28;31;32;27;58;29;41;30;35;62;Common masks;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;28;-4133.94,1346.42;Float;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;29;-4378.016,1507.372;Float;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;31;-3971.28,1351.067;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;27;-3982.048,1184.261;Float;False;Constant;_Horizonline;Horizon line;5;0;Create;True;0;0;False;0;0,-1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;41;-4150.859,1507.372;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;32;-3768.019,1249.981;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;30;-4014.047,1506.423;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;58;-3618.51,1244.758;Float;False;mask_horizon;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;35;-3759.599,1421.607;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;65;-2856.76,960.7812;Float;False;2121.28;503.7731;;24;49;198;56;195;194;40;193;51;192;190;39;52;191;174;37;186;63;38;176;59;185;203;206;207;Sun Halo;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;185;-2824.756,1299.031;Float;False;58;mask_horizon;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;59;-2665.053,1128.283;Float;False;58;mask_horizon;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;-3612.784,1417.461;Float;False;mask_sun_dir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;186;-2607.025,1303.493;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;176;-2457.05,1133.745;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-2680.8,1377.878;Float;False;Property;_SunHaloExponent;Sun Halo Exponent;6;0;Create;True;0;0;False;0;500;100;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-2665.097,1214.205;Float;False;62;mask_sun_dir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-2453.359,1321.936;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;174;-2456.954,1219.298;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;52;-2295.161,1134.135;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-2291.767,1056.127;Float;False;Constant;_Float0;Float 0;15;0;Create;True;0;0;False;0;40;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;190;-2090.816,1037.198;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;39;-2284.786,1263.525;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;192;-1940.554,1036.973;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;179;-2853.514,2161.845;Float;False;1523.875;386.7999;;12;157;196;156;152;150;151;149;178;148;211;212;213;Horizon Line;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;123;-2855.521,257.5181;Float;False;1151.353;548.3238;;9;121;117;114;112;183;118;119;120;115;Sky Gradient;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-2106.385,1184.939;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;40;-1960.01,1184.631;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;112;-2819.656,629.438;Float;False;58;mask_horizon;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;193;-1805.77,1036.973;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;148;-2803.514,2211.845;Float;False;58;mask_horizon;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;194;-1621.83,1161.893;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;183;-2602.641,634.4753;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;178;-2594.673,2217.804;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;104;-2850.166,1611.696;Float;False;1624.908;409.4686;;15;73;197;72;103;101;102;70;68;69;66;82;208;209;210;214;Sun Disc;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;56;-1695.978,1270.707;Float;False;Property;_SunHaloColor;Sun Halo Color;7;0;Create;True;0;0;False;0;1,0,0,1;0.7735849,0.69112,0.6239765,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;115;-2721.872,709.6203;Float;False;Property;_SkyGradientExponent;Sky Gradient Exponent;11;0;Create;True;0;0;False;1;Header(Sky Gradient);1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;203;-1489.565,1269.987;Float;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;195;-1478.056,1161.724;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;-2818.462,1728.415;Float;False;62;mask_sun_dir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;114;-2466.114,658.6555;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;149;-2461.843,2218.348;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;151;-2547.886,2297.943;Float;False;Property;_HorizonLineExponent;Horizon Line Exponent;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-2676.605,1805.542;Float;False;Property;_SunDiscExponent;Sun Disc Exponent;2;0;Create;True;0;0;False;0;100000;100000;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;120;-2371.255,304.2181;Float;False;Property;_SkyGradientBottom;Sky Gradient Bottom;12;0;Create;True;0;0;False;0;0,0,0,0;0.9339623,0.8828825,0.7621484,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;119;-2369.347,478.0306;Float;False;Property;_SkyGradientTop;Sky Gradient Top;13;0;Create;True;0;0;False;0;0,0,0,0;0.909804,0.8745099,0.764706,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;117;-2307.802,657.7333;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;82;-2602.61,1733.012;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;156;-2321.204,2377.511;Float;False;Property;_HorizonLineColor;Horizon Line Color;10;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;198;-1272.591,1203.054;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;150;-2254.306,2245.921;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;207;-1409.565,1351.987;Float;False;Property;_SunHaloContribution;Sun Halo Contribution;5;0;Create;True;0;0;False;1;Header(Sun Halo);1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;68;-2444.857,1755.76;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;152;-2085.951,2243.704;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;206;-1107.565,1236.987;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;211;-2101.901,2376.08;Float;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;118;-2082.168,460.0819;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;102;-2363.495,1668.168;Float;False;Property;_SunDiscMultiplier;Sun Disc Multiplier;3;0;Create;True;0;0;False;0;100000;100000;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;70;-2290.789,1756.594;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;213;-2038.428,2452.471;Float;False;Property;_HorizonLineContribution;Horizon Line Contribution;8;0;Create;True;0;0;False;1;Header(Horizon Line);1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;-1915.915,456.1562;Float;False;sky_gradient;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;-943.4849,1232.302;Float;False;sun_halo;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;196;-1905.171,2295.174;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;202;-562.0143,941.3812;Float;False;1610.083;526.7283;;14;0;200;216;201;218;217;172;171;169;161;168;106;124;219;Putting it all togethor;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;-497.5317,1128.272;Float;False;121;sky_gradient;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-2135.49,1696.95;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;212;-1734.742,2343.011;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;106;-469.7835,1040.544;Float;False;49;sun_halo;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;72;-2210.124,1832.789;Float;False;Property;_SunDiscColor;Sun Disc Color;4;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;103;-1990.271,1696.76;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;208;-2000.772,1833.223;Float;False;FLOAT3;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;168;-240.5411,1068.418;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;157;-1570.039,2337.982;Float;False;horizon_line;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;214;-1804.894,1675.334;Float;False;mask_sundisk;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;197;-1804.405,1753.325;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;169;-72.89522,1068.419;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;161;-129.2854,1167.088;Float;False;157;horizon_line;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;210;-1926.772,1907.223;Float;False;Property;_SunDiscContribution;Sun Disc Contribution;1;0;Create;True;0;0;False;1;Header(Sun Disc);1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;171;132.7733,1105.364;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;217;50.70691,1244.746;Float;False;214;mask_sundisk;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;209;-1619.772,1788.223;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;73;-1461.81,1781.622;Float;False;sun_disc;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;218;268.7069,1249.746;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;172;278.7107,1105.319;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;201;434.4943,1064.692;Float;False;73;sun_disc;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;216;471.7069,1166.746;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;219;837.493,985.4356;Float;False;Property;_Title;Title;0;0;Create;True;0;0;True;1;MaterialTitle(SKY);0;0;0;1;INT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;200;655.5494,1106.315;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;797.207,1059.076;Half;False;True;2;Half;ASEMaterialInspector;0;0;Unlit;danielshervheim/STYLIZED/SKY;False;False;False;False;True;True;True;True;True;True;False;False;False;False;True;True;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Background;;Background;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;14;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;31;0;28;0
WireConnection;41;0;29;0
WireConnection;32;0;27;0
WireConnection;32;1;31;0
WireConnection;30;0;41;0
WireConnection;58;0;32;0
WireConnection;35;0;31;0
WireConnection;35;1;30;0
WireConnection;62;0;35;0
WireConnection;186;0;185;0
WireConnection;176;0;59;0
WireConnection;37;0;186;0
WireConnection;37;1;38;0
WireConnection;174;0;63;0
WireConnection;52;0;176;0
WireConnection;190;0;52;0
WireConnection;190;1;191;0
WireConnection;39;0;174;0
WireConnection;39;1;37;0
WireConnection;192;0;190;0
WireConnection;51;0;52;0
WireConnection;51;1;39;0
WireConnection;40;0;51;0
WireConnection;193;0;192;0
WireConnection;194;0;193;0
WireConnection;194;1;40;0
WireConnection;183;0;112;0
WireConnection;178;0;148;0
WireConnection;203;0;56;0
WireConnection;195;0;194;0
WireConnection;114;0;183;0
WireConnection;114;1;115;0
WireConnection;149;0;178;0
WireConnection;117;0;114;0
WireConnection;82;0;66;0
WireConnection;198;0;195;0
WireConnection;198;1;203;0
WireConnection;150;0;149;0
WireConnection;150;1;151;0
WireConnection;68;0;82;0
WireConnection;68;1;69;0
WireConnection;152;0;150;0
WireConnection;206;1;198;0
WireConnection;206;2;207;0
WireConnection;211;0;156;0
WireConnection;118;0;120;0
WireConnection;118;1;119;0
WireConnection;118;2;117;0
WireConnection;70;0;68;0
WireConnection;121;0;118;0
WireConnection;49;0;206;0
WireConnection;196;0;152;0
WireConnection;196;1;211;0
WireConnection;101;0;102;0
WireConnection;101;1;70;0
WireConnection;212;1;196;0
WireConnection;212;2;213;0
WireConnection;103;0;101;0
WireConnection;208;0;72;0
WireConnection;168;0;106;0
WireConnection;168;1;124;0
WireConnection;157;0;212;0
WireConnection;214;0;103;0
WireConnection;197;0;103;0
WireConnection;197;1;208;0
WireConnection;169;0;168;0
WireConnection;171;0;169;0
WireConnection;171;1;161;0
WireConnection;209;1;197;0
WireConnection;209;2;210;0
WireConnection;73;0;209;0
WireConnection;218;0;217;0
WireConnection;172;0;171;0
WireConnection;216;0;172;0
WireConnection;216;1;218;0
WireConnection;200;0;201;0
WireConnection;200;1;216;0
WireConnection;0;2;200;0
ASEEND*/
//CHKSM=492C0C067AACC25AD979A3FC309F2D2BCCE90040