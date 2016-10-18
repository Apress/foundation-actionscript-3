package com.foundationAS3.ch11 {
    import flash.display.MovieClip;

    import com.foundationAS3.ch11.XMLManager;

    public class Main extends MovieClip {
        private var xmlMan:XMLManager;

        public function Main() {
            trace("Main constructor");
            xmlMan = new XMLManager();
        }

    }
}