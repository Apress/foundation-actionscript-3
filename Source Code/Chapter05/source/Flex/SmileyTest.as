package {
    import flash.display.Sprite;
    import com.foundationAS3.ch5.Smiley;

    [SWF(width=550, height=400)]
    public class SmileyTest extends Sprite {

        public function SmileyTest() {
            // Create and center smiley sprite on stage
            var smiley:Smiley = new Smiley();
            addChild(smiley);
            smiley.x = stage.stageWidth / 2;
            smiley.y = stage.stageHeight / 2;
        }

    }
}