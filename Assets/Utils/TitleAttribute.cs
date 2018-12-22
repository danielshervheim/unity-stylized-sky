using UnityEngine;
using System;

public class TitleAttribute : PropertyAttribute {
	public String title;

    public TitleAttribute(String title) {
    	this.title = title;
    }
}