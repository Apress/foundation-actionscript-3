package {
    // Import necessary classes
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.ColorTransform;
    import flash.geom.Rectangle;

    public class Ball extends Sprite {

        // Horizontal speed and direction
        public var speedX:int = 10;

        // Vertical speed and direction
        public var speedY:int = -10;

        // Constructor, draws circle
        public function Ball() {
            addEventListener(Event.ENTER_FRAME, onEnterFrame);

            // Draws a circle
            graphics.beginFill(0xFF, 1);
            graphics.drawCircle(0, 0, 25);
            graphics.endFill();

            // Colors the ball a random color
            var colorTransform:ColorTransform = new ColorTransform();
            colorTransform.color = Math.random() * 0xFFFFFF;
            transform.colorTransform = colorTransform;
        }

        // Called every frame
        private function onEnterFrame(event:Event):void {
            // Move ball by appropriate amount
            x += speedX;
            y += speedY;

            // Get boundary rectangle for ball
            var bounds:Rectangle = getBounds(parent);

            // Reverse horizontal direction if collided with left or right
            // of stage.
            if (bounds.left < 0 || bounds.right > stage.stageWidth) {
                speedX *= -1;
            }

            // Reverse vertical direction if collided with top or bottom
            // of stage.
            if (bounds.top < 0 || bounds.bottom > stage.stageHeight) {
                speedY *= -1;
            }
        }

    }
}