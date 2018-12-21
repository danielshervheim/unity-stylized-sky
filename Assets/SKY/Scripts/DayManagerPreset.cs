using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

[Serializable]
public class DayManagerPreset {

	public String label_;
	public Material skyMaterial_;
	public Material cloudMaterial_;
	public float start_;
	public float end_;
	public bool visible_ = false;

	public DayManagerPreset(int i) {
		label_ = "Element " + i;
	}

	public DayManagerPreset(String label) {
		label_ = label;
	}
}
