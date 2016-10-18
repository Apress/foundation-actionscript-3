package com.foundationAS3.ch4 {
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.StageDisplayState;
    import flash.events.MouseEvent;

    public class FullScreenTest extends Sprite {

        public function FullScreenTest() {
            circle.addEventListener(MouseEvent.CLICK, onButtonClick);
        }

        private function onButtonClick(event:MouseEvent):void {
            stage.displayState = StageDisplayState.FULL_SCREEN;
        }

    }
}