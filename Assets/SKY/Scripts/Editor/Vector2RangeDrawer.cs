// Draws a Vector2 variable using the Vector2Range attribute as a slider.

using UnityEngine;
using UnityEditor;
using System;

[CustomPropertyDrawer(typeof(Vector2RangeAttribute))]
public class Vector2RangeDrawer : PropertyDrawer {
	private float x = 0.25f;
	private float y = 0.75f;

    public override void OnGUI(Rect position, SerializedProperty property, GUIContent label) {
        Vector2RangeAttribute vector2range = attribute as Vector2RangeAttribute;

        if (property.propertyType == SerializedPropertyType.Vector2) {
        	x = property.vector2Value.x;
        	y = property.vector2Value.y;
        	String tmp = vector2range.label + " [" + x.ToString("0.##") + ", " + y.ToString("0.##") + "]";
        	EditorGUI.MinMaxSlider(position, tmp, ref x, ref y, vector2range.min, vector2range.max);
        	property.vector2Value = new Vector2(x, y);
        }
        else {
        	EditorGUI.LabelField(position, label.text, "Use Vector2Range with Vector2.");
        }
    }
}