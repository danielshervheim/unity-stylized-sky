using System;
using UnityEditor;
using UnityEngine;

[Serializable]
public class FloatRange {
	public float start;
	public float end;

	public FloatRange(float start, float end) {
		this.start = start;
		this.end = end;
	}
}

[CustomPropertyDrawer(typeof(FloatRange))]
public class FloatRangeDrawer : PropertyDrawer {
    public override void OnGUI(Rect position, SerializedProperty property, GUIContent label) {
    	float start = property.FindPropertyRelative("start").floatValue;
		float end = property.FindPropertyRelative("end").floatValue;

		String msg = /*label.text +*/ "[" + start.ToString("0.##") + ", " + end.ToString("0.##") + "]";
        EditorGUI.MinMaxSlider(position, msg, ref start, ref end, 0f, 1f);
        
        property.FindPropertyRelative("start").floatValue = start;
        property.FindPropertyRelative("end").floatValue = end;
    }
}