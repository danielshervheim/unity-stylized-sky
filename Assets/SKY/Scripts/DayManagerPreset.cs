using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

[Serializable]
public class DayManagerPreset {

	public String label;
	public Material sky;
	public Material cloud;
	[Vector2Range("Time", 0f, 1f)]
	public Vector2 range;

	public void SetPresetBlend(DayManagerPreset other, float t, ref Material skyMat, ref Material cloudMat) {
		if (t < 0 || t > 1) {
			Debug.LogError("t out of range");
			return;
		}

		if (skyMat.shader != Shader.Find("danielshervheim/STYLIZED/SKY")) {
			Debug.LogError("skyMat must use \"danielshervheim/STYLIZED/SKY\"");
			return;
		}

		if (cloudMat.shader != Shader.Find("danielshervheim/STYLIZED/CLOUD")) {
			Debug.LogError("cloudMat must use \"danielshervheim/STYLIZED/CLOUD\"");
			return;
		}

		// set sky material values
		skyMat.SetFloat("_SunDiscContribution",
			Mathf.Lerp(sky.GetFloat("_SunDiscContribution"), other.sky.GetFloat("_SunDiscContribution"), t));

		skyMat.SetFloat("_SunDiscExponent",
			Mathf.Lerp(sky.GetFloat("_SunDiscExponent"), other.sky.GetFloat("_SunDiscExponent"), t));

		skyMat.SetFloat("_SunDiscMultiplier",
			Mathf.Lerp(sky.GetFloat("_SunDiscMultiplier"), other.sky.GetFloat("_SunDiscMultiplier"), t));

		skyMat.SetColor("_SunDiscColor",
			Color.Lerp(sky.GetColor("_SunDiscColor"), other.sky.GetColor("_SunDiscColor"), t));

		skyMat.SetFloat("_SunHaloContribution",
			Mathf.Lerp(sky.GetFloat("_SunHaloContribution"), other.sky.GetFloat("_SunHaloContribution"), t));

		skyMat.SetFloat("_SunHaloExponent",
			Mathf.Lerp(sky.GetFloat("_SunHaloExponent"), other.sky.GetFloat("_SunHaloExponent"), t));

		skyMat.SetColor("_SunHaloColor",
			Color.Lerp(sky.GetColor("_SunHaloColor"), other.sky.GetColor("_SunHaloColor"), t));

		skyMat.SetFloat("_HorizonLineContribution",
			Mathf.Lerp(sky.GetFloat("_HorizonLineContribution"), other.sky.GetFloat("_HorizonLineContribution"), t));

		skyMat.SetFloat("_HorizonLineExponent",
			Mathf.Lerp(sky.GetFloat("_HorizonLineExponent"), other.sky.GetFloat("_HorizonLineExponent"), t));

		skyMat.SetColor("_HorizonLineColor",
			Color.Lerp(sky.GetColor("_HorizonLineColor"), other.sky.GetColor("_HorizonLineColor"), t));

		skyMat.SetFloat("_SkyGradientExponent",
			Mathf.Lerp(sky.GetFloat("_SkyGradientExponent"), other.sky.GetFloat("_SkyGradientExponent"), t));

		skyMat.SetColor("_SkyGradientBottom",
			Color.Lerp(sky.GetColor("_SkyGradientBottom"), other.sky.GetColor("_SkyGradientBottom"), t));

		skyMat.SetColor("_SkyGradientTop",
			Color.Lerp(sky.GetColor("_SkyGradientTop"), other.sky.GetColor("_SkyGradientTop"), t));

		// TODO: set cloud material values
	}

	public void SetPreset(ref Material skyMat, ref Material cloudMat) {
		if (skyMat.shader != Shader.Find("danielshervheim/STYLIZED/SKY")) {
			Debug.LogError("skyMat must use \"danielshervheim/STYLIZED/SKY\"");
			return;
		}

		if (cloudMat.shader != Shader.Find("danielshervheim/STYLIZED/CLOUD")) {
			Debug.LogError("cloudMat must use \"danielshervheim/STYLIZED/CLOUD\"");
			return;
		}

		// set sky material values
		skyMat.SetFloat("_SunDiscContribution",
			sky.GetFloat("_SunDiscContribution"));
		
		skyMat.SetFloat("_SunDiscExponent",
			sky.GetFloat("_SunDiscExponent"));
		
		skyMat.SetFloat("_SunDiscMultiplier",
			sky.GetFloat("_SunDiscMultiplier"));
		
		skyMat.SetColor("_SunDiscColor",
			sky.GetColor("_SunDiscColor"));
		
		skyMat.SetFloat("_SunHaloContribution",
			sky.GetFloat("_SunHaloContribution"));
		
		skyMat.SetFloat("_SunHaloExponent",
			sky.GetFloat("_SunHaloExponent"));
		
		skyMat.SetColor("_SunHaloColor",
			sky.GetColor("_SunHaloColor"));
		
		skyMat.SetFloat("_HorizonLineContribution",
			sky.GetFloat("_HorizonLineContribution"));
		
		skyMat.SetFloat("_HorizonLineExponent",
			sky.GetFloat("_HorizonLineExponent"));
		
		skyMat.SetColor("_HorizonLineColor",
			sky.GetColor("_HorizonLineColor"));
		
		skyMat.SetFloat("_SkyGradientExponent",
			sky.GetFloat("_SkyGradientExponent"));
		
		skyMat.SetColor("_SkyGradientBottom",
			sky.GetColor("_SkyGradientBottom"));
		
		skyMat.SetColor("_SkyGradientTop",
			sky.GetColor("_SkyGradientTop"));

		// TODO: set cloud material values
	}

}
