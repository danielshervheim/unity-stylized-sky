using UnityEngine;

public class Vector2RangeAttribute : PropertyAttribute
{
    public float min;
    public float max;

    public Vector2RangeAttribute(float min, float max)
    {
        this.min = min;
        this.max = max;
    }
}