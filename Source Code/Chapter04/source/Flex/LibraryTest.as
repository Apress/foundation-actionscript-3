package {
    import flash.display.Sprite;

    [SWF(width=550, height=400)]
    public class LibraryTest extends Sprite {

        public function LibraryTest() {
            var ball:Ball = new Ball();
            addChild(ball);
        }

    }
}

import flash.display.GradientType;
import flash.display.Sprite;
import flash.geom.Matrix;

class Ball extends Sprite {

    public function Ball() {
        var colors:Array = [];
        var pMatrix:Matrix = new Matrix();
        pMatrix.createGradientBox(70, 70, 0, -20, -10);
        graphics.beginGradientFill(GradientType.RADIAL, [0xFF0000, 0x330000], [1, 1], [0, 0xFF], pMatrix);
        graphics.drawCircle(25, 25, 25);
        graphics.endFill();
    }

}