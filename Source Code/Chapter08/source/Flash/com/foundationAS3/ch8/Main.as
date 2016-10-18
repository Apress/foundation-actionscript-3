package com.foundationAS3.ch8 {
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;

    import com.foundationAS3.ch8.Sounds;
    import com.foundationAS3.ch8.ButtonManager;

    public class Main extends MovieClip {
        private var soundManager:Sounds;
        private var buts:ButtonManager;

        public function Main() {
            soundManager = new Sounds(movScreen,
                    movScrubber,
                    txtStatus,
                    txtHeadPosition,
                    txtTrackLength,
                    txtArtist,
                    txtTitle,
                    volumeSlider,
                    panSlider);
            soundManager.loadSong("song1.mp3");
            addChild(soundManager);

            buts = new ButtonManager(butRW,
                    butPlay,
                    butPause,
                    butStop,
                    butFF);
            buts.addMediaControlListener(soundManager.onControlCommand);
        }

    }
}