package {
    // Import necessary classes
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.geom.ColorTransform;
    import flash.geom.Rectangle;

    public class Ball extends MovieClip {

        // Horizontal speed and direction
        public var speedX:int = 10;

        // Vertical speed and direction
        public var speedY:int = -10;

        // Constructor
        public function Ball() {
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
            // Colors the ball a random color
            var colorTransform:ColorTransform = new ColorTransform();
            colorTransform.color = Math.random() * 0xFFFFFF;
            transform.colorTransform = colorTransform;
        }

        // Called every frame
        private function onEnterFrame(event:Event):void {
            // Move ball by appripriate amount
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