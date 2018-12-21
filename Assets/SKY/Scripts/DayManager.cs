using System.Collections;
using System.Collections.Generic;
using UnityEngine;



public class DayManager : MonoBehaviour {

	public Transform sun_;
	public float sunYaw_ = 0f;
	private float sunPitch_ = 0f;

	public Material sky_;
	public Material cloud_;
	
	public float dayDuration_ = 24;  // in minutes
	public bool pauseTime_ = true;
	public float currentTimeNormalized_ = 0f;  // should be read-only

	public DayManagerPreset[] presets;

	void Start () {
		sun_.rotation = Quaternion.identity;
	}
	
	void Update () {
		if (!pauseTime_) {
			// update the sun rotation based on the elapsed time of day
			sunPitch_ += Time.deltaTime * 360f / (dayDuration_ * 60f);
			sun_.rotation = Quaternion.Euler(sunPitch_, sunYaw_, 0f);
		}
		
		currentTimeNormalized_ = (Vector3.Dot(-sun_.forward, Vector3.up) + 1f) / 2f;
	}
}
