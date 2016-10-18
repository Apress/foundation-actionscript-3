package com.foundationAS3.ch4 {
    import flash.display.MovieClip;
    import flash.display.Sprite;

    public class DisplayTest extends Sprite {

        public function DisplayTest() {
            trace(square);

            // Move to (300,300)
            square.x = 300;
            square.y = 300;

            // Stretch horizontally and squash vertically
            square.scaleX = 2;
            square.scaleY = 0.5;

            // Make 50% alpha
            square.alpha = 0.5;

            // Rotate 45 degrees
            square.rotation = 45;
        }

    }
}
