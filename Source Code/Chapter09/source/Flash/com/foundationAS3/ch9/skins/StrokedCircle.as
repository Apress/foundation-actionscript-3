package com.foundationAS3.ch9.skins {
    import flash.display.Shape;

    public class StrokedCircle extends Shape {

        protected var _fillColor:uint = 0xE6E6E6;
        protected var _strokeColor:uint = 0x5C5C5C;

        public function StrokedCircle() {
            init();
        }

        protected function init():void {
            draw();
        }

        private function draw():void {
            graphics.lineStyle(1, _strokeColor);
            graphics.beginFill(_fillColor);
            graphics.drawCircle(25, 25, 25);
            graphics.endFill();
        }

    }
}