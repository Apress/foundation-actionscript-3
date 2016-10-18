package {
    import flash.display.BlendMode;
    import flash.display.Sprite;

    [SWF(width=550, height=400)]
    public class DepthTest extends Sprite {

        public function DepthTest() {
            var square:Square = new Square();
            addChild(square);
            square.x = 10;
            square.y = 10;

            var square2:Square = new Square();
            addChild(square2);
            square2.x = 43;
            square2.y = 66;

            var square3:Square = new Square();
            addChild(square3);
            square3.x = 93;
            square3.y = 31;

            trace("square: " + getChildIndex(square));
            trace("square2: " + getChildIndex(square2));
            trace("square3: " + getChildIndex(square3));

            setChildIndex(square, numChildren - 1);

            trace("square: " + getChildIndex(square));
            trace("square2: " + getChildIndex(square2));
            trace("square3: " + getChildIndex(square3));

            swapChildren(square2, square3);
            swapChildrenAt(0, 2);

            trace("square: " + getChildIndex(square));
            trace("square2: " + getChildIndex(square2));
            trace("square3: " + getChildIndex(square3));

            square3.blendMode = BlendMode.INVERT;
        }

    }
}

import flash.display.Sprite;

class Square extends Sprite {

    public function Square() {
        graphics.lineStyle(5);
        graphics.beginFill(0xFF);
        graphics.drawRect(0, 0, 100, 100);
        graphics.endFill();
    }

}