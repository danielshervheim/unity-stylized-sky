using System;
using UnityEditor;
using UnityEngine;

public class MaterialTitleDrawer : MaterialPropertyDrawer {
    private String title;

    public MaterialTitleDrawer(String title) {
        this.title = title;
    }

    public override void OnGUI(Rect position, MaterialProperty prop, String label, MaterialEditor editor) {
        position.y += 8;
        EditorGUI.LabelField(position, title, EditorStyles.largeLabel);
    }

    public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor) {
        return 24;
    }
}