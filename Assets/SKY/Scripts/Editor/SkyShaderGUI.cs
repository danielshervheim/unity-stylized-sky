using System;
using UnityEngine;
using UnityEditor;

public class SkyShaderGUI : ShaderGUI  {

	float sunDiscContribution = 1f;
	float sunDiscExponent = 500000f;
	float sunDiscMultiplier = 100000f;
	Color sunDiscColor = Color.black;

	float sunHaloContribution = 1f;
	float sunHaloExponent = 750f;
	Color sunHaloColor = Color.black;
	
	float horizonLineContribution = 1f;
	float horizonLineExponent = 5.75f;
	Color horizonLineColor = Color.black;
	
	float skyGradientExponent = 0.5f;
	Color skyGradientBottomColor = Color.black;
	Color skyGradientTopColor = Color.black;

	bool FirstTimeApply = true;

    public override void OnGUI (MaterialEditor materialEditor, MaterialProperty[] properties) {
        Material material = materialEditor.target as Material;

        if (FirstTimeApply) {
   			sunDiscContribution = material.GetFloat("_SunDiscContribution");
        	sunDiscExponent = material.GetFloat("_SunDiscExponent");
        	sunDiscMultiplier = material.GetFloat("_SunDiscMultiplier");
        	sunDiscColor = material.GetColor("_SunDiscColor");

        	sunHaloContribution = material.GetFloat("_SunHaloContribution");
        	sunHaloExponent = material.GetFloat("_SunHaloExponent");
        	sunHaloColor = material.GetColor("_SunHaloColor");

        	horizonLineContribution = material.GetFloat("_HorizonLineContribution");
        	horizonLineExponent = material.GetFloat("_HorizonLineExponent");
        	horizonLineColor = material.GetColor("_HorizonLineColor");

        	skyGradientExponent = material.GetFloat("_SkyGradientExponent");
        	skyGradientBottomColor = material.GetColor("_SkyGradientBottom");
        	skyGradientTopColor = material.GetColor("_SkyGradientTop");

       		FirstTimeApply = false;
    	}

        EditorGUI.BeginChangeCheck();

        GUIStyle header = new GUIStyle();
        header.fontStyle = FontStyle.Bold;

        GUIStyle title = new GUIStyle();
        title.richText = true;

        EditorGUILayout.LabelField("<size=15>Stylized Sky</size>", title);

        EditorGUILayout.Space();
        EditorGUILayout.LabelField("Sun Disc", header);
	    sunDiscContribution = EditorGUILayout.Slider("Contribution", sunDiscContribution, 0.0f, 1.0f);
		sunDiscExponent = EditorGUILayout.FloatField("Exponent", sunDiscExponent);
		sunDiscMultiplier = EditorGUILayout.FloatField("Multiplier", sunDiscMultiplier);
		sunDiscColor = EditorGUILayout.ColorField("Color", sunDiscColor);

		EditorGUILayout.Space();
		EditorGUILayout.LabelField("Sun Halo", header);
		sunHaloContribution = EditorGUILayout.Slider("Contribution", sunHaloContribution, 0.0f, 1.0f);
		sunHaloExponent = EditorGUILayout.FloatField("Exponent", sunHaloExponent);
		sunHaloColor = EditorGUILayout.ColorField("Color", sunHaloColor);
		
		EditorGUILayout.Space();
		EditorGUILayout.LabelField("Horizon Line", header);
		horizonLineContribution = EditorGUILayout.Slider("Contribution", horizonLineContribution, 0.0f, 1.0f);
		horizonLineExponent = EditorGUILayout.FloatField("Exponent", horizonLineExponent);
		horizonLineColor = EditorGUILayout.ColorField("Color", horizonLineColor);
		
		EditorGUILayout.Space();
		EditorGUILayout.LabelField("Sky Gradient", header);
		skyGradientExponent = EditorGUILayout.FloatField("Exponent", skyGradientExponent);
		skyGradientBottomColor = EditorGUILayout.ColorField("Bottom Color", skyGradientBottomColor);
		skyGradientTopColor = EditorGUILayout.ColorField("Top Color", skyGradientTopColor);

        if (EditorGUI.EndChangeCheck()) {
        	material.SetFloat("_SunDiscContribution", sunDiscContribution);
        	material.SetFloat("_SunDiscExponent", sunDiscExponent);
        	material.SetFloat("_SunDiscMultiplier", sunDiscMultiplier);
        	material.SetColor("_SunDiscColor", sunDiscColor);

        	material.SetFloat("_SunHaloContribution", sunHaloContribution);
        	material.SetFloat("_SunHaloExponent", sunHaloExponent);
        	material.SetColor("_SunHaloColor", sunHaloColor);

        	material.SetFloat("_HorizonLineContribution", horizonLineContribution);
        	material.SetFloat("_HorizonLineExponent", horizonLineExponent);
        	material.SetColor("_HorizonLineColor", horizonLineColor);

        	material.SetFloat("_SkyGradientExponent", skyGradientExponent);
        	material.SetColor("_SkyGradientBottom", skyGradientBottomColor);
        	material.SetColor("_SkyGradientTop", skyGradientTopColor);
        }
    }
}