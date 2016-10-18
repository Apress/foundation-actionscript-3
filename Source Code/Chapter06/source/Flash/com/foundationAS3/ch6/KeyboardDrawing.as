package com.foundationAS3.ch6 {
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    public class KeyboardDrawing extends Sprite {

        private const PIXEL_DISTANCE_TO_DRAW:uint = 2;

        private var _canvas:Sprite;
        private var _crosshair:Shape;

        private var _xDirection:int = 0;
        private var _yDirection:int = 0;
        private var _isDrawing:Boolean = false;

        public function KeyboardDrawing() {
            _canvas = new Sprite();
            addChild(_canvas);
            _crosshair = new Shape();
            drawCrosshair();
            addChild(_crosshair);

            // Prepare canvas for drawing and keyboard input
            _canvas.graphics.lineStyle(2, 0x000000);
            stage.focus = _canvas;

            // Add canvas event listeners
            _canvas.addEventListener(KeyboardEvent.KEY_DOWN, onCanvasKeyDown);
            _canvas.addEventListener(KeyboardEvent.KEY_UP, onCanvasKeyUp);
            _canvas.addEventListener(Event.ENTER_FRAME, onCanvasEnterFrame);
        }

        private function drawCrosshair():void {
            _crosshair.graphics.lineStyle(1, 0x000000);
            _crosshair.graphics.moveTo(-5, 0);
            _crosshair.graphics.lineTo(6, 0);
            _crosshair.graphics.moveTo(0, -5);
            _crosshair.graphics.lineTo(0, 6);
        }

        private function onCanvasKeyDown(event:KeyboardEvent):void {
            switch (event.keyCode) {
                case Keyboard.UP:
                    _yDirection = -PIXEL_DISTANCE_TO_DRAW;
                    break;
                case Keyboard.DOWN:
                    _yDirection = PIXEL_DISTANCE_TO_DRAW;
                    break;
                case Keyboard.LEFT:
                    _xDirection = -PIXEL_DISTANCE_TO_DRAW;
                    break;
                case Keyboard.RIGHT:
                    _xDirection = PIXEL_DISTANCE_TO_DRAW;
                    break;
                case Keyboard.SPACE:
                    _isDrawing = true;
                    break;
            }
        }

        private function onCanvasKeyUp(event:KeyboardEvent):void {
            switch (event.keyCode) {
                case Keyboard.UP:
                case Keyboard.DOWN:
                    _yDirection = 0;
                    break;
                case Keyboard.LEFT:
                case Keyboard.RIGHT:
                    _xDirection = 0;
                    break;
                case Keyboard.SPACE:
                    _isDrawing = false;
                    break;
            }
        }

        private function onCanvasEnterFrame(event:Event):void {
            _crosshair.x += _xDirection;
            _crosshair.y += _yDirection;

            if (_isDrawing) {
                _canvas.graphics.lineTo(_crosshair.x, _crosshair.y);
            } else {
                _canvas.graphics.moveTo(_crosshair.x, _crosshair.y);
            }
        }

    }
}