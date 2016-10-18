package com.foundationAS3.ch6 {
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    public class DrawingApplication extends Sprite {

        private var _canvas:Sprite;

        public function DrawingApplication() {
            _canvas = new Sprite();

            _canvas.graphics.beginFill(0xF0F0F0);
            _canvas.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            _canvas.graphics.endFill();

            _canvas.graphics.lineStyle(2, 0x000000);

            addChild(_canvas);

            _canvas.addEventListener(MouseEvent.MOUSE_DOWN, onCanvasMouseDown);
            _canvas.addEventListener(MouseEvent.MOUSE_UP, onCanvasMouseUp);
        }

        private function onCanvasMouseDown(event:MouseEvent):void {
            _canvas.graphics.moveTo(event.localX, event.localY);
            _canvas.addEventListener(MouseEvent.MOUSE_MOVE, onCanvasMouseMove);
        }

        private function onCanvasMouseMove(event:MouseEvent):void {
            _canvas.graphics.lineTo(event.localX, event.localY);
            event.updateAfterEvent();
        }

        private function onCanvasMouseUp(event:MouseEvent):void {
            _canvas.graphics.lineTo(event.localX, event.localY);
            _canvas.removeEventListener(MouseEvent.MOUSE_MOVE, onCanvasMouseMove);
        }

    }
}