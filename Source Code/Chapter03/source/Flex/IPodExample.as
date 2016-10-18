package {
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    [SWF(width=550, height=400)]
    public class IPodExample extends Sprite {

        public var myIPod:IPod;

        // Constructor
        public function IPodExample() {
            init();
        }

        // Initialization method
        private function init():void {
            createNextButton();
            createIPod();
        }

        // Instantiates new IPod and tells it to play
        private function createIPod():void {
            myIPod = new IPod("A101", "Steve’s iPod", 11);
            myIPod.tracks.push("Guns ‘n’ Roses - Estranged");
            myIPod.tracks.push("Muse - Supermassive Black Holes");
            myIPod.tracks.push("Evanescence - Good Enough");

            myIPod.play();
        }

        // Creates button to go to next track
        private function createNextButton():void {
            var nextButton:Sprite = new Sprite();
            nextButton.graphics.beginFill(0xFF);
            nextButton.graphics.drawCircle(0, 0, 25);
            nextButton.graphics.endFill();
            addChild(nextButton);
            nextButton.x = stage.stageWidth / 2;
            nextButton.y = stage.stageHeight / 2;
            nextButton.addEventListener(MouseEvent.CLICK, onNextButtonClick);
        }

        // Handler for next button click
        private function onNextButtonClick(event:MouseEvent):void {
            myIPod.next();
        }

    }
}