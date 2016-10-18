package {
    import flash.display.Sprite;
    import flash.filters.*;

    [SWF(width=550, height=400)]
    public class FilterTest extends Sprite {

        public function FilterTest() {
            var square:Square = new Square();
            square.x = 150;
            square.y = 150;
            addChild(square);

            var square2:Square = new Square();
            square2.x = 300;
            square2.y = 150;
            addChild(square2);

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

import flash.display.Sprite;

class Square extends Sprite {

    public function Square() {
        graphics.lineStyle(3);
        graphics.beginFill(0xFFFFFF);
        graphics.drawRect(0, 0, 100, 100);
        graphics.endFill();
    }

}