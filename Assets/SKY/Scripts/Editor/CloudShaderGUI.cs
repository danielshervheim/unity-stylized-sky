using System;
using UnityEngine;
using UnityEditor;

public class CloudShaderGUI : ShaderGUI  {

	float shadowMultiplier;
	Color shadedColor;
	Color litColor;

	float sssContribution;
	float sssMultiplier;
	float sssExponent;
	Color sssColor;

	bool FirstTimeApply = true;

    public override void OnGUI (MaterialEditor materialEditor, MaterialProperty[] properties) {
        Material material = materialEditor.target as Material;

        if (FirstTimeApply) {
        	shadowMultiplier = material.GetFloat("_ShadowMultiplier");
        	shadedColor = material.GetColor("_ShadowColor");
        	litColor = material.GetColor("_LitColor");

        	sssContribution = material.GetVector("_SSS").x;
        	sssMultiplier = material.GetVector("_SSS").y;
        	sssExponent = material.GetVector("_SSS").z;
        	sssColor = material.GetColor("_SSSColor");

       		FirstTimeApply = false;
    	}

    	EditorGUI.BeginChangeCheck();

        GUIStyle header = new GUIStyle();
        header.fontStyle = FontStyle.Bold;

        GUIStyle title = new GUIStyle();
        title.richText = true;

        EditorGUILayout.LabelField("<size=15>Stylized Cloud</size>", title);

        EditorGUILayout.Space();
        EditorGUILayout.LabelField("Shading", header);
        shadowMultiplier = EditorGUILayout.FloatField("Multiplier", shadowMultiplier);
        shadedColor = EditorGUILayout.ColorField("Shaded Color", shadedColor);
        litColor = EditorGUILayout.ColorField("Lit Color", litColor);

        EditorGUILayout.Space();
        EditorGUILayout.LabelField("Sub-Surface Scattering", header);
        sssContribution = EditorGUILayout.Slider("Contribution", sssContribution, 0f, 1f);
        sssMultiplier = EditorGUILayout.FloatField("Multiplier", sssMultiplier);
        sssExponent = EditorGUILayout.FloatField("Exponent", sssExponent);
        sssColor = EditorGUILayout.ColorField("Color", sssColor);

        if (EditorGUI.EndChangeCheck()) {
        	material.SetFloat("_ShadowMultiplier", shadowMultiplier);
        	material.SetColor("_ShadowColor", shadedColor);
        	material.SetColor("_LitColor", litColor);

        	material.SetVector("_SSS", new Vector3(sssContribution, sssMultiplier, sssExponent));
        	material.SetColor("_SSSColor", sssColor);

        }
    }
}
