package com.foundationAS3.ch5 {
    import flash.display.Sprite;

    public class SmileyTest extends Sprite {

        public function SmileyTest() {
            // Create and center smiley sprite on stage
            var smiley:Smiley = new Smiley();
            addChild(smiley);
            smiley.x = stage.stageWidth / 2;
            smiley.y = stage.stageHeight / 2;
        }

    }
}