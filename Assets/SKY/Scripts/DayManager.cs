using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class DayManager : MonoBehaviour {

	[Space]
	[Title("☀️ Day Manager")]

	[Header("Sun Settings")]
	public Transform sun;
	public float sunYaw = 0f;
	private float sunPitch = 0f;
	
	[Header("Day Settings")]
	public float dayDuration = 24;  // in minutes
	public bool pauseTime = true;
	[ReadOnly] public float currentTimeNormalized = 0f;  // should be read-only

	[Header("Materials")]
	public Material sky;
	public Material cloud;

	[Header("Presets")]
	public DayManagerPreset[] presets;

	void Start () {
		sun.rotation = Quaternion.identity;
	}
	
	void Update () {
		if (!pauseTime) {
			// update the sun rotation based on the elapsed time of day
			sunPitch += Time.deltaTime * 360f / (dayDuration * 60f);
			sun.rotation = Quaternion.Euler(sunPitch, sunYaw, 0f);
		}
		
		currentTimeNormalized = (Vector3.Dot(-sun.forward, Vector3.up) + 1f) / 2f;

		for (int i = 0; i < presets.Length; i++) {
			int nextI = (i+1) % presets.Length;
			if (currentTimeNormalized <= presets[i].range.end) {
				presets[i].SetPreset(ref sky, ref cloud);
				break;
			}
			else if (currentTimeNormalized < presets[nextI].range.start) {
				float x = (currentTimeNormalized - presets[i].range.end) / (presets[nextI].range.start - presets[i].range.end);
				presets[i].SetPresetBlend(presets[nextI], x, ref sky, ref cloud);
				break;	
			}
			// else do nothing. the next iteration will catch it.
		}
	}
}
