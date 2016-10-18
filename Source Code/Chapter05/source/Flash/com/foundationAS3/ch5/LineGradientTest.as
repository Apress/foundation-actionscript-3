package com.foundationAS3.ch5 {
    import flash.display.GradientType;
    import flash.display.Shape;
    import flash.display.Sprite;

    public class LineGradientTest extends Sprite {

        public function LineGradientTest() {
            // Create and center ellipse shape on stage
            var ellipse:Shape = new Shape();
            addChild(ellipse);
            ellipse.x = stage.stageWidth / 2;
            ellipse.y = stage.stageHeight / 2;

            // Set basic line style
            ellipse.graphics.lineStyle(30);

            // Set up gradient properties
            var colors:Array =
                    [
                        0xFF0000,
                        0xFF6600,
                        0xFFFF00,
                        0x00FF00,
                        0x0000FF,
                        0x2E0854,
                        0x8F5E99
                    ];
            var alphas:Array = [1, 1, 1, 1, 1, 1, 1];
            var ratios:Array = [0, 42, 84, 126, 168, 210, 255];

            // Set gradient line style
            ellipse.graphics.lineGradientStyle(GradientType.LINEAR, colors, alphas, ratios);

            // Draw ellipse
            ellipse.graphics.drawEllipse(-100, -50, 200, 100);
        }

    }
}