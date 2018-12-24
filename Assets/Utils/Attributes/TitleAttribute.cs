using System;
using UnityEditor;
using UnityEngine;

[System.AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = true)]
public class TitleAttribute : PropertyAttribute {
    public readonly String title;

    public TitleAttribute(String title) {
       this.title = title;
    }
}

[CustomPropertyDrawer(typeof(TitleAttribute))]
public class TitleDrawer : DecoratorDrawer {
	public override void OnGUI(Rect position) {
        position.y += 8;
    	EditorGUI.LabelField(position, (attribute as TitleAttribute).title, EditorStyles.largeLabel);
    }

    public override float GetHeight() {
        return 24;
    }
}