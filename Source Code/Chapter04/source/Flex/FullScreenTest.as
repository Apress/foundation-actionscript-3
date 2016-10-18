package {
    import flash.display.Sprite;
    import flash.display.StageDisplayState;
    import flash.events.MouseEvent;

    [SWF(width=550, height=400)]
    public class FullScreenTest extends Sprite {

        public function FullScreenTest() {
            var circle:Circle = new Circle();
            circle.x = 275;
            circle.y = 200;
            addChild(circle);

            circle.addEventListener(MouseEvent.CLICK, onButtonClick);
        }

        private function onButtonClick(event:MouseEvent):void {
            stage.displayState = StageDisplayState.FULL_SCREEN;
        }

    }
}

import flash.display.Sprite;

class Circle extends Sprite {

    public function Circle() {
        graphics.lineStyle(1);
        graphics.beginFill(0xFFCF7F);
        graphics.drawCircle(0, 0, 39);
        graphics.endFill();
    }

}