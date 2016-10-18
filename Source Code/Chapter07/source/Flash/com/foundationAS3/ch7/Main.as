package com.foundationAS3.ch7 {
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;

    import com.foundationAS3.ch7.Videos;
    import com.foundationAS3.ch7.ButtonManager;

    public class Main extends MovieClip {
        private var vids:Videos;
        public var buts:ButtonManager;

        public function Main() {
            vids = new Videos(movScrubber, txtStatus, txtHeadPosition, txtTrackLength);
            addChild(vids);
            buts = new ButtonManager(butRW, butPlay, butPause, butStop, butFF);
            buts.addMediaControlListener(vids.onControlCommand);
        }

    }
}