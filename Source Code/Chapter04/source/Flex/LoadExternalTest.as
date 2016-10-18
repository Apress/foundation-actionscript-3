package {
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.net.URLRequest;

    [SWF(width=550, height=400)]
    public class LoadExternalTest extends Sprite {

        public function LoadExternalTest() {
            var loader:Loader = new Loader();
            addChild(loader);
            loader.load(new URLRequest("audrey_computer.png"));
        }

    }
}