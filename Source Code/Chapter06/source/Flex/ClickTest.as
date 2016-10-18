package {
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    [SWF(width=550, height=400)]
    public class ClickTest extends Sprite {

        public function ClickTest() {
            var square:Sprite = new Sprite();
            square.graphics.lineStyle(2, 0x000000);
            square.graphics.beginFill(0xff0000);
            square.graphics.drawRect(0, 0, 100, 100);
            square.graphics.endFill();
            addChild(square);

            square.doubleClickEnabled = true;

            square.addEventListener(MouseEvent.CLICK, onSquareClick);
            square.addEventListener(MouseEvent.DOUBLE_CLICK, onSquareDoubleClick);
        }

        private function onSquareClick(event:MouseEvent):void {
            trace("ouch!");
        }

        private function onSquareDoubleClick(event:MouseEvent):void {
            trace("double ouch!");
        }

    }
}