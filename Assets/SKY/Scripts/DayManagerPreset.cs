using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

[Serializable]
public class DayManagerPreset {

	public String label_;
	public Material sky_;
	public Material cloud_;
	[Vector2Range(0f, 1f)]
	public Vector2 range_;
	public bool visible_ = false;

	public DayManagerPreset(int i, int numPresets) {
		label_ = "Element " + i;

		float delta = 1f / numPresets;
		range_.x = i * delta;
		range_.y = (i+1) * delta;

		visible_ = false;
	}
}
