package com.foundationAS3.ch4 {
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.filters.*;

    public class FilterTest extends Sprite {

        public function FilterTest() {
            var glow:GlowFilter = new GlowFilter(0x00FF00, 1, 10, 10);
            var dropShadow:DropShadowFilter = new DropShadowFilter();
            square.filters = [glow, dropShadow];
            square2.filters = [dropShadow, glow];

            // Change glow to blue
            glow.color = 0x0000FF;
            square.filters = [glow, dropShadow];

            // Change angle of drop shadow
            var filters:Array = square2.filters;
            for each (var filter:BitmapFilter in filters) {
                if (filter is DropShadowFilter) {
                    (filter as DropShadowFilter).angle = 270;
                }
            }
            square2.filters = filters;

            // Remove drop shadow
            filters = square.filters;
            filters.pop();
            square.filters = filters;
        }

    }
}