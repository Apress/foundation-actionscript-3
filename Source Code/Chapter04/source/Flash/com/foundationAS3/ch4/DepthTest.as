package com.foundationAS3.ch4 {

	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class DepthTest extends Sprite {
	
		public function DepthTest() {
			trace("square: " + getChildIndex(square));
			trace("square2: " + getChildIndex(square2));
			trace("square3: " + getChildIndex(square3));
			
			setChildIndex(square, numChildren-1);
			
			trace("square: " + getChildIndex(square));
			trace("square2: " + getChildIndex(square2));
			trace("square3: " + getChildIndex(square3));
			
			swapChildren(square2, square3);
			swapChildrenAt(0, 2);
			
			trace("square: " + getChildIndex(square));
			trace("square2: " + getChildIndex(square2));
			trace("square3: " + getChildIndex(square3));
			
			square3.blendMode = BlendMode.INVERT;
		}
	
	}
	
}