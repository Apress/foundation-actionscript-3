/**
 * Class to provide rotating dial UI control for selection within a range of values.
 */
package com.foundationAS3.ch9.controls {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    public class Dial extends Sprite {

        private var _graphic:Sprite;
        private var _startRadians:Number;
        private var _startRotation:Number;
        private var _minValue:Number = 0;
        private var _maxValue:Number = 100;

        /**
         * Constructor.
         */
        public function Dial() {
            init();
        }

        /**
         * Initialization script.
         */
        private function init():void {
            _graphic = graphic;
            addEventListener(MouseEvent.MOUSE_DOWN, onClickDial);
        }

        /**
         * Handler for when the dial is clicked, adds a MOUSE_MOVE listener and saves initial rotation and click position.
         *
         * @param  event  The event fired by this instance.
         */
        private function onClickDial(event:MouseEvent):void {
            _startRotation = _graphic.rotation;
            var click:Point = new Point(mouseX - _graphic.x, mouseY - _graphic.y);
            _startRadians = Math.atan2(click.y, click.x);
            addEventListener(MouseEvent.MOUSE_MOVE, onRotateDial);
            stage.addEventListener(MouseEvent.MOUSE_UP, onReleaseDial);
        }

        /**
         * Handler for when the mouse is released after first clicking the dial, removes the MOUSE_MOVE listener.
         *
         * @param  event  The event fired by the stage.
         */
        private function onReleaseDial(event:MouseEvent):void {
            removeEventListener(MouseEvent.MOUSE_MOVE, onRotateDial);
            stage.removeEventListener(MouseEvent.MOUSE_UP, onReleaseDial);
        }

        /**
         * Handler for when the dial is rotated after first being clicked, updates the graphc position and fires CHANGE event.
         *
         * @param  event  The event fired by this instance.
         */
        private function onRotateDial(event:MouseEvent):void {
            var distance:Point = new Point(mouseX - _graphic.x, mouseY - _graphic.y);
            var radians:Number = Math.atan2(distance.y, distance.x) - _startRadians;
            var degrees:Number = radians * 180 / Math.PI;
            _graphic.rotation = _startRotation + degrees;
            dispatchEvent(new Event(Event.CHANGE));
        }

        /**
         * Returns the current value of the component, based on its rotation.
         *
         * @returns  The numeric value within the range, determined by the current rotation as a percentage of full rotation.
         */
        public function get value():Number {
            var degrees:Number = _graphic.rotation;
            if (degrees < 0) degrees += 360;
            return degrees / 360 * (_maxValue - _minValue) + _minValue;
        }

        /**
         * Sets the value of the component and rotates the dial accordingly.
         *
         * @param  num  The value within the range at which to set the dial.
         */
        [Inspectable(defaultValue=0)]
        public function set value(num:Number):void {
            _graphic.rotation = (num - _minValue) / (_maxValue - _minValue) * 360;
        }

        /**
         * Returns the minimum range value for the component.
         *
         * @returns  The lower limit of the component range.
         */
        public function get minValue():Number {
            return _minValue;
        }

        /**
         * Sets the minimum range value for the component.
         *
         * @param  min  The value to be the lower limit of the component range.
         */
        [Inspectable(defaultValue=0)]
        public function set minValue(min:Number):void {
            _minValue = min;
        }

        /**
         * Returns the maximum range value for the component.
         *
         * @returns  The upper limit of the component range.
         */
        public function get maxValue():Number {
            return _maxValue;
        }

        /**
         * Sets the maximum range value for the component.
         *
         * @param  max  The value to be the upper limit of the component range.
         */
        [Inspectable(defaultValue=100)]
        public function set maxValue(max:Number):void {
            _maxValue = max;
        }

    }
}