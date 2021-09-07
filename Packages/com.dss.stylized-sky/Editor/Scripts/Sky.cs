using UnityEditor;
using UnityEngine;

using static DSS.CoreUtils.EditorUtilities.GUIUtilities;
using DSS.CoreUtils.EditorUtilities;

namespace DSS.Stylized
{

public class Sky : ShaderGUI
{
    override public void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        MaterialPropertyContainer props = new MaterialPropertyContainer(properties);

        Section("", () =>
        {
            Title("Stylized Sky");
        });

        Section("Gradient", () =>
        {
            MaterialProperty gradientTop = props["_SkyGradientTop"];
            MaterialProperty gradientBottom = props["_SkyGradientBottom"];
            MaterialProperty gradientExponent = props["_SkyGradientExponent"];

            materialEditor.ShaderProperty(gradientTop, "Top Color");
            materialEditor.ShaderProperty(gradientBottom, "Bottom Color");
            materialEditor.ShaderProperty(gradientExponent, "Exponent");
            gradientExponent.floatValue = Mathf.Max(gradientExponent.floatValue, 0f);
        });

        Section("Horizon", () =>
        {
            MaterialProperty horizonColor = props["_HorizonLineColor"];
            MaterialProperty horizonContribution = props["_HorizonLineContribution"];
            MaterialProperty horizonExponent = props["_HorizonLineExponent"];

            materialEditor.ShaderProperty(horizonColor, "Color");
            materialEditor.ShaderProperty(horizonContribution, "Contribution");
            materialEditor.ShaderProperty(horizonExponent, "Exponent");
            horizonExponent.floatValue = Mathf.Max(horizonExponent.floatValue, 0f);
        });

        Section("Sun Halo", () =>
        {
            MaterialProperty sunHaloColor = props["_SunHaloColor"];
            MaterialProperty sunHaloContribution = props["_SunHaloContribution"];
            MaterialProperty sunHaloExponent = props["_SunHaloExponent"];

            materialEditor.ShaderProperty(sunHaloColor, "Color");
            materialEditor.ShaderProperty(sunHaloContribution, "Contribution");
            materialEditor.ShaderProperty(sunHaloExponent, "Exponent");
            sunHaloExponent.floatValue = Mathf.Max(sunHaloExponent.floatValue, 0f);
        });

        Section("Sun Disc", () =>
        {
            MaterialProperty sunDiscColor = props["_SunDiscColor"];
            MaterialProperty sunDiscMultiplier = props["_SunDiscMultiplier"];
            MaterialProperty sunDiscExponent = props["_SunDiscExponent"];

            materialEditor.ShaderProperty(sunDiscColor, "Color");
            materialEditor.ShaderProperty(sunDiscMultiplier, "Multiplier");
            materialEditor.ShaderProperty(sunDiscExponent, "Exponent");
            sunDiscExponent.floatValue = Mathf.Max(sunDiscExponent.floatValue, 0f);
        });

        Section("Debug", () =>
        {
            MaterialProperty debugMode = props["_DebugMode"];
            debugMode.floatValue = (float)Popup((int)debugMode.floatValue, "Mode", new string[]{"None", "Sky Gradient", "Horizon Gradient", "Sun Halo", "Sun Disc"});
        });
    }
}

}  // namespace DSS.Stylized