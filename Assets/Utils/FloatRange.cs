using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

[Serializable]
public class FloatRange {
	public float start = 0.25f; 
	public float end = 0.75f;

	public FloatRange(float start, float end) {
		this.start = start;
		this.end = end;
	}
}
