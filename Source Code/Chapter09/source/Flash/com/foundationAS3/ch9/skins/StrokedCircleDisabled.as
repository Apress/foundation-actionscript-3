package com.foundationAS3.ch9.skins {

    public class StrokedCircleDisabled extends StrokedCircle {

        override protected function init():void {
            _fillColor = 0xE8E8E8;
            _strokeColor = 0xC2C3C5;
            super.init();
        }

    }
}