using UnityEditor;
using UnityEngine;

[CustomPropertyDrawer(typeof(FloatRange))]
public class FloatRangeDrawer : PropertyDrawer {

	private float start;
	private float end;

    public override void OnGUI(Rect position, SerializedProperty property, GUIContent label) {
    	start = property.FindPropertyRelative("start").floatValue;
        end = property.FindPropertyRelative("end").floatValue;

        EditorGUI.MinMaxSlider(position, "[" + start.ToString("0.##") + ", " + end.ToString("0.##") + "]", ref start, ref end, 0f, 1f);
        
        property.FindPropertyRelative("start").floatValue = start;
        property.FindPropertyRelative("end").floatValue = end;
    }
}