using UnityEngine;
using System;

public class Vector2RangeAttribute : PropertyAttribute
{
    public String label;
    public float min;
    public float max;

    public Vector2RangeAttribute(String label, float min, float max)
    {
    	this.label = label;
        this.min = min;
        this.max = max;
    }
}