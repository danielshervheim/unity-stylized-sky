using UnityEngine;
using UnityEditor;
using System;

[CustomPropertyDrawer(typeof(TitleAttribute))]
public class TitleDrawer : DecoratorDrawer {

	private int titleFontSize = 16;

	private TitleAttribute titleAttribute {
        get { return ((TitleAttribute)attribute); }
    }

	public override float GetHeight() {
        return base.GetHeight()/2f + titleFontSize;
    }

    public override void OnGUI(Rect position) {
    	GUIStyle titleFontStyle = new GUIStyle();
    	titleFontStyle.richText = true;
        EditorGUI.LabelField(position, "<size=" + titleFontSize.ToString() + ">" + titleAttribute.title + "</size>", titleFontStyle);
    }
}