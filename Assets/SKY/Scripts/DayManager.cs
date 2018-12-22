using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DayManager : MonoBehaviour {
	public Transform sun;
	public float sunYaw = 0f;
	private float sunPitch = 0f;

	public Material sky;
	public Material cloud;
	
	public float dayDuration = 24;  // in minutes
	public bool pauseTime = true;
	public float currentTimeNormalized = 0f;  // should be read-only

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
			if (currentTimeNormalized <= presets[i].range.y) {
				presets[i].SetPreset(ref sky, ref cloud);
				break;
			}
			else if (currentTimeNormalized < presets[nextI].range.x) {
				float x = (currentTimeNormalized - presets[i].range.y) / (presets[nextI].range.x - presets[i].range.y);
				presets[i].SetPresetBlend(presets[nextI], x, ref sky, ref cloud);
				break;	
			}
			// else do nothing. the next iteration will catch it.
		}
	}
}
