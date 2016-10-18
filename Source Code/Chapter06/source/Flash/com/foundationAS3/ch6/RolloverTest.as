package com.foundationAS3.ch6 {
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    public class RolloverTest extends Sprite {

        private static var UP_COLOR:uint = 0xFF0000;
        private static var ROLLOVER_COLOR:uint = 0x0000FF;

        private var _square:Sprite;

        public function RolloverTest() {
            _square = new Sprite();
            drawSquare(UP_COLOR);
            addChild(_square);

            _square.doubleClickEnabled = true;

            _square.addEventListener(MouseEvent.CLICK, onSquareClick);
            _square.addEventListener(MouseEvent.DOUBLE_CLICK, onSquareDoubleClick);
            _square.addEventListener(MouseEvent.ROLL_OVER, onSquareRollOver);
            _square.addEventListener(MouseEvent.ROLL_OUT, onSquareRollOut);
        }

        private function drawSquare(color:uint):void {
            _square.graphics.clear();
            _square.graphics.lineStyle(2, 0x000000);
            _square.graphics.beginFill(color);
            _square.graphics.drawRect(0, 0, 100, 100);
            _square.graphics.endFill();
        }

        private function onSquareClick(event:MouseEvent):void {
            trace("ouch!");
        }

        private function onSquareDoubleClick(event:MouseEvent):void {
            trace("double ouch!");
        }

        private function onSquareRollOver(event:MouseEvent):void {
            drawSquare(ROLLOVER_COLOR);
        }

        private function onSquareRollOut(event:MouseEvent):void {
            drawSquare(UP_COLOR);
        }

    }
}