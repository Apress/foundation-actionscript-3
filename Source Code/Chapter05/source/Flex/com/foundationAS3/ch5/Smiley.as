package com.foundationAS3.ch5 {
    import flash.display.GradientType;
    import flash.display.Shape;
    import flash.geom.Matrix;

    public class Smiley extends Shape {

        public function Smiley() {
            with (graphics) {
                // Draw face
                lineStyle(5);
                var colors:Array = [0xFFFF66, 0xFFFF00, 0xCCCC00];
                var alphas:Array = [1, 1, 1];
                var ratios:Array = [0, 128, 255];
                var matrix:Matrix = new Matrix();
                matrix.createGradientBox(
                        200,
                        200,
                        (45 * (Math.PI / 180)),
                        -100,
                        -100
                );
                beginGradientFill(
                        GradientType.RADIAL,
                        colors,
                        alphas,
                        ratios,
                        matrix,
                        null,
                        null,
                        -0.5
                );
                drawCircle(0, 0, 100);
                endFill();

                // Draw eyes
                lineStyle();
                beginFill(0x000000);
                drawCircle(-35, -30, 10);
                drawCircle(35, -30, 10);
                endFill();

                // Draw glasses
                lineStyle(5);
                beginFill(0xFFFFFF, 0.3);
                drawRoundRect(-60, -50, 50, 40, 20, 20);
                drawRoundRect(10, -50, 50, 40, 20, 20);
                endFill();
                moveTo(-60, -30);
                lineTo(-80, -40);
                moveTo(-10, -30);
                curveTo(0, -40, 10, -30);
                moveTo(60, -30);
                lineTo(80, -40);

                // Draw mouth
                moveTo(-45, 30);
                beginFill(0xFFFFFF);
                curveTo(0, 50, 45, 30);
                curveTo(0, 90, -45, 30);
                endFill();
            }
        }

    }
}