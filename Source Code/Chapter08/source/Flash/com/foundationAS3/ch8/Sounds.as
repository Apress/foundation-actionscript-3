package com.foundationAS3.ch8 {
    import flash.events.Event;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.TimerEvent;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.GlowFilter;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundLoaderContext;
    import flash.media.SoundTransform;
    import flash.media.SoundMixer;
    import flash.media.ID3Info;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.utils.ByteArray;
    import flash.utils.Timer;

    import fl.controls.Slider;
    import fl.events.SliderEvent;

    public class Sounds extends MovieClip {
        private var snd:Sound;
        private var soundChannelVar:SoundChannel;
        private var buffer:SoundLoaderContext;
        private var timerLoading:Timer;
        private var timerPlayHead:Timer;
        private var timerFF:Timer;
        private var timerRW:Timer;
        private var timerSpectrum:Timer;
        private var barWid:int = 200;
        private var barHi:int = 5;
        private var bytLoaded:int;
        private var bytTotal:int;
        private var pctLoaded:int;
        private var trueChronoLength:Number;
        private var txtStatus:TextField;
        private var txtTrackLength:TextField;
        private var txtHeadPosition:TextField;
        private var txtArtist:TextField;
        private var txtTitle:TextField;
        private var movScreen:MovieClip;
        private var movScrubber:MovieClip;
        private var multiplier:Number;
        private var nsMinutes:Number;
        private var nsSeconds:Number;
        private var pauseStatus:Boolean;
        private var playHeadPosition:Number;
        private var volumeSlider:Slider;
        private var panSlider:Slider;
        private var stVolume:SoundTransform;
        private var tempVol:Number = 0.5;
        private var tempPan:Number = 0;
        private var trackEnd:Boolean;
        private var trackStart:Boolean;
        private var baSpectrum:ByteArray;
        private var grFrequency:Sprite;
        private var w:uint = 1;
        private var spread:Number;
        private var glow:GlowFilter;


        // CONSTRUCTOR
        public function Sounds(movScreen:MovieClip,
                               movScrubber:MovieClip,
                               txtStatus:TextField,
                               txtHeadPosition:TextField,
                               txtTrackLength:TextField,
                               txtArtist:TextField,
                               txtTitle:TextField,
                               volumeSlider:Slider,
                               panSlider:Slider) {
            // Set movies and text fields to local references and to start positions and contents
            this.movScreen = movScreen;
            this.movScrubber = movScrubber;
            this.txtStatus = txtStatus;
            this.txtHeadPosition = txtHeadPosition;
            this.txtTrackLength = txtTrackLength;
            this.txtArtist = txtArtist;
            this.txtTitle = txtTitle;
            this.volumeSlider = volumeSlider;
            this.panSlider = panSlider;
            movScrubber.movLoaderBar.width = 1;
            txtStatus.text = "AWAITING LOCATION";

            buffer = new SoundLoaderContext(5000);//Song buffer size in milliseconds
            stVolume = new SoundTransform();
            baSpectrum = new ByteArray();
            grFrequency = new Sprite();
            grFrequency.x = 0;
            grFrequency.y = 200;
            movScreen.movSpectrum.addChild(grFrequency);
            glow = new GlowFilter()

            // Set volume Controls
            volumeSlider.addEventListener(SliderEvent.CHANGE, onVolSliderChange);
            panSlider.addEventListener(SliderEvent.CHANGE, onPanSliderChange);

            // Add Timers
            timerLoading = new Timer(100, 0);
            timerLoading.addEventListener(TimerEvent.TIMER, onLoading);
            timerLoading.start();
            timerPlayHead = new Timer(500, 0);
            timerPlayHead.addEventListener(TimerEvent.TIMER, this.headPosition);
            timerFF = new Timer(100, 0)
            timerFF.addEventListener(TimerEvent.TIMER, this.runFF);
            timerRW = new Timer(100, 0)
            timerRW.addEventListener(TimerEvent.TIMER, this.runRW);
            timerSpectrum = new Timer(100, 0);
            timerSpectrum.addEventListener(TimerEvent.TIMER, onSpectrum);
            // NB don't forget to stop the Timer when finished
        }

        //---------------- Load song into Sound instance ----------------
        public function loadSong(song:String):void {
            snd = new Sound(new URLRequest(song), buffer);
            //Add event listeners for completion of loading and for ID3 information
            snd.addEventListener(Event.ID3, id3Handler)
        }

        //----------------- Loader Timer handler -----------------------
        private function onLoading(event:TimerEvent):void {
            bytLoaded = snd.bytesLoaded;
            bytTotal = snd.bytesTotal;
            if ((bytTotal >= bytLoaded) && (bytLoaded > 0)) {
                if (txtStatus.text != "Playing") {
                    txtStatus.text = "Loading";
                }
                movScrubber.movLoaderBar.width = ((bytLoaded / bytTotal) * 100) * 4;
                if (bytLoaded == bytTotal) {
                    if (txtStatus.text == "Loading") {
                        txtStatus.text = "Load Complete";
                    }
                    timerLoading.stop();
                }
            }
        }

        //------------------ HEAD POSITION & COUNT --------------------
        private function headPosition(event:TimerEvent):void {
            multiplier = (1 / (snd.bytesLoaded / snd.bytesTotal));
            trueChronoLength = snd.length * multiplier;
            if (txtStatus.text == "Playing") {
                if (trueChronoLength > 0) {
                    movScrubber.movHead.width = ((Math.floor(soundChannelVar.position) / trueChronoLength) * 100) * 4;
                }

                // Set timer display text field
                nsMinutes = Math.floor((soundChannelVar.position / 1000) / 60);
                nsSeconds = Math.floor((soundChannelVar.position / 1000) % 60);
                if (nsSeconds < 10) {
                    this.txtHeadPosition.text = nsMinutes.toString() + ":0" + nsSeconds.toString();
                } else {
                    this.txtHeadPosition.text = nsMinutes.toString() + ":" + nsSeconds.toString();
                }
            }

            // Set track total length display text field
            var tlMinutes:int = Math.floor((trueChronoLength / 1000) / 60);
            if (tlMinutes < 1) {
                tlMinutes = 0
            }
            var tlSeconds:int = Math.floor((trueChronoLength / 1000) % 60);
            if (tlSeconds < 10) {
                txtTrackLength.text = tlMinutes.toString() + ":0" + tlSeconds.toString();
            } else {
                txtTrackLength.text = tlMinutes.toString() + ":" + tlSeconds.toString();
            }
        }

        //----------------- ID3 information event handler -----------------
        function id3Handler(event:Event):void {
            var song:Sound = Sound(event.target);
            var songInfo:ID3Info = ID3Info(song.id3);//The ID3Info class translates the ID3 tags into more legible calls for the information - eg TPE1 becomes artist
            for (var xx in songInfo) {
                trace("ID3 - " + xx + " is " + songInfo[xx]);
            }
            txtArtist.text = songInfo.artist;
            txtTitle.text = songInfo.songName;
        }


        //------------------COMPUTE SPECTRUM ------------------------
        private function onSpectrum(evt:Event):void {
            SoundMixer.computeSpectrum(baSpectrum, false);
            grFrequency.graphics.clear();
            grFrequency.graphics.beginFill(0x00FF00);
            grFrequency.graphics.moveTo(0, 0);
            for (var i:int = 0; i < 512; i += w) {
                spread = (baSpectrum.readFloat() * 150);
                grFrequency.graphics.drawRect(i, 0, w, -spread);
            }
            // Apply the glow filter to the grFrequency graphic.
            glow.color = 0x009922;
            glow.alpha = 1;
            glow.blurX = 25;
            glow.blurY = 25;
            glow.quality = BitmapFilterQuality.MEDIUM;
            grFrequency.filters = [glow];
        }

        //----------------- CONTROL BUTTONS ---------------------------
        public function onControlCommand(evt:MediaControlEvent):void {
            switch (evt.command) {
                //---- PAUSE ----
                case "PAUSE":
                    if (pauseStatus) {
                        soundChannelVar = snd.play(playHeadPosition, 1);//Play offset , number of loops
                        restoreVolPan();
                        timerSpectrum.start();
                        pauseStatus = false;
                    } else {
                        timerSpectrum.stop();
                        grFrequency.graphics.clear();
                        storeVolPan();
                        soundChannelVar.stop();
                        pauseStatus = true;
                    }
                    txtStatus.text = (txtStatus.text == "Playing") ? "Paused" : "Playing";
                    break;
                //---- PLAY ----
                case "PLAY":
                    if (txtStatus.text != "Playing") {
                        soundChannelVar = snd.play(0, 1);//Play offset , number of loops
                        timerPlayHead.start();
                        restoreVolPan();
                        timerSpectrum.start();
                        txtStatus.text = "Playing";
                        trackEnd = false;
                    }
                    break;
                //---- STOP ----
                case "STOP":
                    timerPlayHead.stop();
                    txtStatus.text = "Stopped";
                    timerSpectrum.stop();
                    grFrequency.graphics.clear();
                    storeVolPan();
                    soundChannelVar.stop();
                    movScrubber.movHead.width = 1;
                    txtHeadPosition.text = "0:00";
                    break;
                //---- RW ----
                case "RW":
                    timerSpectrum.stop();
                    grFrequency.graphics.clear();
                    storeVolPan();
                    soundChannelVar.stop();
                    timerRW.start();
                    txtStatus.text = "Rewind";
                    break;
                //---- RW END ----
                case "RWEND":
                    timerRW.stop();
                    if (!trackStart) {
                        soundChannelVar = snd.play(playHeadPosition, 1);//Play offset , number of loops
                        txtStatus.text = "Playing";
                        restoreVolPan();
                        timerSpectrum.start();
                    }
                    break;
                //---- FF ----
                case "FF":
                    timerSpectrum.stop();
                    grFrequency.graphics.clear();
                    storeVolPan();
                    soundChannelVar.stop();
                    timerFF.start();
                    txtStatus.text = "Fast Forward";
                    break;
                //---- FF END ----
                case "FFEND":
                    timerFF.stop();
                    if (!trackEnd) {
                        soundChannelVar = snd.play(playHeadPosition, 1);//Play offset , number of loops
                        txtStatus.text = "Playing";
                        restoreVolPan();
                        timerSpectrum.start();
                    }
                    break;
                default:
                    trace("BUTTON COMMAND ERROR");
                    break;
            }
        }

        // Fast Forward
        private function runFF(event:TimerEvent):void {
            if (playHeadPosition < trueChronoLength) {
                playHeadPosition += 1000;
                movScrubber.movHead.width = ((Math.floor(playHeadPosition) / trueChronoLength) * 100) * 4;
            } else {
                trackEnd = true;
                txtHeadPosition.text = txtTrackLength.text;
                txtStatus.text = "End of track";
                movScrubber.movHead.width = 400;
            }
        }

        // Rewind
        private function runRW(event:TimerEvent):void {
            if (playHeadPosition > 1) {
                playHeadPosition -= 1000;
                movScrubber.movHead.width = ((Math.floor(playHeadPosition) / trueChronoLength) * 100) * 4;
            } else {
                trackStart = true;
                txtHeadPosition.text = "0:00";
                txtStatus.text = "Start of track";
                movScrubber.movHead.width = 1;
            }
        }

        // Store volume and pan settings for reapplication
        private function storeVolPan():void {
            playHeadPosition = soundChannelVar.position;
            tempVol = stVolume.volume;
            tempPan = stVolume.pan;
        }

        // Reapply pan and volume settings
        private function restoreVolPan():void {
            stVolume.pan = tempPan;
            stVolume.volume = tempVol;
            soundChannelVar.soundTransform = stVolume;
        }

        // Set volume
        private function onVolSliderChange(evt:SliderEvent):void {
            stVolume.volume = (evt.value / 100);
            soundChannelVar.soundTransform = stVolume;
        }

        // Set pan
        private function onPanSliderChange(evt:SliderEvent):void {
            stVolume.pan = (evt.value / 100);
            soundChannelVar.soundTransform = stVolume;
        }

    }
}