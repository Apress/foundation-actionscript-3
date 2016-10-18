package {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;

    public class MultiBounce extends MovieClip {

        // Number of balls to create
        private static const NUM_BALLS:uint = 50;

        // Constructor
        public function MultiBounce() {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageClick);

        }

        // Handler for when stage is clicked, creates balls
        private function onStageClick(pEvent:MouseEvent):void {
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, onStageClick);
            // For each ball to be created
            for (var i:uint = 0; i < NUM_BALLS; i++) {
                // Create new Ball instance
                var ball:Ball = new Ball();

                // Places ball at mouse click
                ball.x = pEvent.stageX;
                ball.y = pEvent.stageY;

                // Specify random speed and direction
                ball.speedX = (Math.random() * 30) - 15;
                ball.speedY = (Math.random() * 30) - 15;

                // Add new Ball to stage
                addChild(ball);
            }
        }

    }
}