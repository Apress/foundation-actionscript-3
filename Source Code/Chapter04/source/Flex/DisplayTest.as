package {
    import flash.display.Sprite;

    [SWF(width=550, height=400)]
    public class DisplayTest extends Sprite {

        public function DisplayTest() {
            var square:Square = new Square();
            addChild(square);

            // Move to (300,300)
            square.x = 300;
            square.y = 300;

            // Stretch horizontally and squash vertically
            square.scaleX = 2;
            square.scaleY = 0.5;

            // Make 50% alpha
            square.alpha = 0.5;

            // Rotate 45 degrees
            square.rotation = 45;
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