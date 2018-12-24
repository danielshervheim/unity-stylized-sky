using UnityEngine;
using System;

[Serializable]
public class TimeOfDayPreset {
	public String label;

	[Header("Materials")]
	public Material sky;
	public Material cloud;
	
	[Header("Sun Settings")]
	public Color sunLightColor;

	[Header("Fog Settings")]
	public float fogDensity;
	public float fogStartDistance;
	public float fogEndDistance;
	public Color fogColor;

	[Header("Time Range")]
	public FloatRange range;
}
