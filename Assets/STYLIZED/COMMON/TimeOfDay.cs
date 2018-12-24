using UnityEngine;
using System;

public class TimeOfDay : MonoBehaviour {

	[Title("☀ Time Of Day")]

	[Header("Sun Settings")]
	public Transform sun;
	public float sunYaw = 0f;
	private float sunPitch = 0f;
	
	[Header("Day Settings")]
	public float dayDuration = 24;  // in minutes
	public bool pauseTime = true;
	[ReadOnly] public float currentTimeNormalized = 0f;  // should be read-only

	[Header("Fog Settings")]
	public bool fog;
	public FogMode fogMode = FogMode.Exponential;

	[Header("Materials")]
	public Material sky;
	public Material cloud;

	[Header("Presets")]
	public TimeOfDayPreset[] presets;

	void Start () {
		sun.rotation = Quaternion.identity;
		RenderSettings.skybox = sky;
		RenderSettings.sun = sun.GetComponent<Light>();
		RenderSettings.fog = fog;
		RenderSettings.fogMode = fogMode;
	}
	
	void Update () {
		if (!pauseTime) {
			// update the sun rotation based on the elapsed time of day
			sunPitch += Time.deltaTime * 360f / (dayDuration * 60f);
			sun.rotation = Quaternion.Euler(sunPitch, sunYaw, 0f);
		}
		
		currentTimeNormalized = (Vector3.Dot(-sun.forward, Vector3.up) + 1f) / 2f;

		// find which current time-preset we are in and apply it (or a blend, if we are between two presets)
		for (int i = 0; i < presets.Length; i++) {
			int nextI = (i+1) % presets.Length;
			if (currentTimeNormalized <= presets[i].range.end) {
				ApplyPreset(presets[i]);
				break;
			}
			else if (currentTimeNormalized < presets[nextI].range.start) {
				float blendFactor = (currentTimeNormalized - presets[i].range.end) / (presets[nextI].range.start - presets[i].range.end);
				ApplyPresetBlend(presets[i], presets[nextI], blendFactor);
				break;
			}
		}
	}

	private void ApplyPreset(TimeOfDayPreset p) {
		sky.Lerp(p.sky, p.sky, 0.0f);
		cloud.Lerp(p.cloud, p.cloud, 0.0f);
		RenderSettings.sun.color = p.sunLightColor;
		
		if (RenderSettings.fog) {
			RenderSettings.fogDensity = p.fogDensity;
			RenderSettings.fogStartDistance = p.fogStartDistance;
			RenderSettings.fogEndDistance = p.fogEndDistance;
			RenderSettings.fogColor = p.fogColor;
		}
	}

	private void ApplyPresetBlend(TimeOfDayPreset a, TimeOfDayPreset b, float t) {
		sky.Lerp(a.sky, b.sky, t);
		cloud.Lerp(a.cloud, b.cloud, t);
		RenderSettings.sun.color = Color.Lerp(a.sunLightColor, b.sunLightColor, t);
		
		if (RenderSettings.fog) {
			RenderSettings.fogDensity = Mathf.Lerp(a.fogDensity, b.fogDensity, t);
			RenderSettings.fogStartDistance = Mathf.Lerp(a.fogStartDistance, b.fogStartDistance, t);
			RenderSettings.fogEndDistance = Mathf.Lerp(a.fogEndDistance, b.fogEndDistance, t);
			RenderSettings.fogColor = Color.Lerp(a.fogColor, b.fogColor, t);
		}
	}
}
