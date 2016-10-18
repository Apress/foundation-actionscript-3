package com.foundationAS3.ch7 {
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.media.Video;
    import flash.media.Camera;
    import flash.display.MovieClip;
    import flash.events.TimerEvent;
    import flash.events.NetStatusEvent;
    import flash.utils.Timer;
    import flash.text.TextField;

    import com.foundationAS3.ch7.MediaControlEvent;

    public class Videos extends MovieClip {
        private var vid1:Video;
        private var ncVideoPlayer:NetConnection;
        private var nsVideoPlayer:NetStream;
        private var flvTarget:String;
        private var vidDuration:Number;
        private var trackLength:int;
        private var timerLoading:Timer;
        private var timerPlayHead:Timer;
        private var timerFF:Timer;
        private var timerRW:Timer;
        private var txtStatus:TextField;
        private var txtTrackLength:TextField;
        private var txtHeadPosition:TextField;
        private var bytLoaded:int;
        private var bytTotal:int;
        private var opct:int;
        private var movScrubber:MovieClip;
        private var ns_minutes:Number;
        private var ns_seconds:Number;
        private var seekRate:Number = 3;
        private var headPos:Number;

        // CONSTRUCTOR
        public function Videos(movScrubber:MovieClip,
                               txtStatus:TextField,
                               txtHeadPosition:TextField,
                               txtTrackLength:TextField) {
            // Set movies and text fields to local references and to start positions and contents
            this.movScrubber = movScrubber;
            this.txtStatus = txtStatus;
            this.txtHeadPosition = txtHeadPosition;
            this.txtTrackLength = txtTrackLength;
            movScrubber.movLoaderBar.width = 1;
            movScrubber.movHead.alpha = 0;
            txtStatus.text = "AWAITING LOCATION";

            // Instantiates vars and connect NC
            ncVideoPlayer = new NetConnection();
            ncVideoPlayer.connect(null);
            nsVideoPlayer = new NetStream(ncVideoPlayer);
            nsVideoPlayer.bufferTime = 10;

            flvTarget = "video_final.flv";

            // Add Event listeners and handlers
            nsVideoPlayer.addEventListener(NetStatusEvent.NET_STATUS, nsOnStatus);

            // Instantiate display objects
            vid1 = new Video();

            // Create a metadata and cuepoint event handling object
            var objTempClient:Object = new Object();
            objTempClient.onMetaData = mdHandler;
            objTempClient.onCuePoint = cpHandler;
            nsVideoPlayer.client = objTempClient;

            // Add Timers
            timerLoading = new Timer(10, 0);
            timerLoading.addEventListener(TimerEvent.TIMER, this.onLoading);
            timerLoading.start();
            timerPlayHead = new Timer(100, 0);
            timerPlayHead.addEventListener(TimerEvent.TIMER, this.headPosition);
            timerPlayHead.start();
            timerFF = new Timer(100, 0)
            timerFF.addEventListener(TimerEvent.TIMER, this.runFF);
            timerRW = new Timer(100, 0)
            timerRW.addEventListener(TimerEvent.TIMER, this.runRW);

            loadFLV();
        }

        //--------- Load FLV source
        public function loadFLV() {
            addChild(vid1);
            vid1.x = 166;
            vid1.y = 77;
            vid1.width = 490;
            vid1.height = 365;
            vid1.attachNetStream(nsVideoPlayer);
            nsVideoPlayer.play(flvTarget);
        }

        //------------- FLV's metadata ------------------------------
        private function mdHandler(obj:Object) {
            for (var x in obj) {
                trace("METADATA " + x + " is " + obj[x]);
                if (x == "trackinfo") {
                    var arrTrackInfo:Array = new Array();
                    arrTrackInfo = obj[x];
                    for (var cnt:Number = 0; cnt < arrTrackInfo.length; cnt++) {
                        for (var yy in arrTrackInfo[cnt]) {
                            trace("METADATA trackinfo - " + yy + " is " + arrTrackInfo[cnt][yy]);
                        }
                    }
                }
                // If this is the duration, format it and display it
                if (x == "duration") {
                    trackLength = obj[x];
                    var tlMinutes:int = trackLength / 60;
                    if (tlMinutes < 1) {
                        tlMinutes = 0
                    }
                    var tlSeconds:int = trackLength % 60;
                    if (tlSeconds < 10) {
                        txtTrackLength.text = tlMinutes.toString() + ":0" + tlSeconds.toString();
                    } else {
                        txtTrackLength.text = tlMinutes.toString() + ":" + tlSeconds.toString();
                    }
                }
            }
        }

        //------------- FLV's cuepoints ------------------------------
        private function cpHandler(obj:Object) {
            for (var c in obj) {
                trace("CUEPOINT " + c + " is " + obj[c]);
                if (c == "parameters") {
                    for (var p in obj[c]) {
                        trace("        PARAMETER " + p + " is " + obj[c][p]);
                    }
                }
            }
        }

        //--------------- ON STATUS LISTENER --------------------------
        public function nsOnStatus(infoObject:NetStatusEvent) {
            for (var prop in infoObject.info) {
                trace("\t" + prop + ":\t" + infoObject.info[prop]);
                // If end of video is found then stop the movHeadSlider moving.
                if (prop == "code" && infoObject.info[prop] == "NetStream.Play.Stop") {
                    txtStatus.text = "Stopped";
                } else if (prop == "code" && infoObject.info[prop] == "NetStream.Play.Start") {
                    txtStatus.text = "Playing";
                    movScrubber.movHead.alpha = 100;
                }
            }
        }

        //------------------ HEAD POSITION & COUNT --------------------
        private function headPosition(event:TimerEvent):void {
            if (trackLength > 0) {
                movScrubber.movHead.width = (nsVideoPlayer.time / (trackLength / 100)) * 4;
            }
            // Set timer display text field
            ns_minutes = int(nsVideoPlayer.time / 60);
            ns_seconds = int(nsVideoPlayer.time % 60);
            if (ns_seconds < 10) {
                this.txtHeadPosition.text = ns_minutes.toString() + ":0" + ns_seconds.toString();
            } else {
                this.txtHeadPosition.text = ns_minutes.toString() + ":" + ns_seconds.toString();
            }
        }

        //------------------- FILE LOADER -----------------------------
        // Load bar calculations & Text field settings
        private function onLoading(event:TimerEvent):void {
            bytLoaded = nsVideoPlayer.bytesLoaded;
            bytTotal = nsVideoPlayer.bytesTotal;
            opct = ((nsVideoPlayer.bytesTotal) / 100);
            movScrubber.movLoaderBar.width = (Math.floor(bytLoaded / opct)) * 4;
            if (bytLoaded == bytTotal) {
                timerLoading.stop();
            }
        }

        //----------------- CONTROL BUTTONS ---------------------------
        public function onControlCommand(evt:MediaControlEvent):void {
            trace(evt.type + " Videos: onControlCommand: " + evt.command);
            switch (evt.command) {
                //---- PAUSE ----
                case "PAUSE":
                    nsVideoPlayer.togglePause();
                    txtStatus.text = (txtStatus.text == "Playing") ? "Paused" : "Playing";
                    break;
                //---- PLAY ----
                case "PLAY":
                    nsVideoPlayer.play(flvTarget);
                    break;
                //---- STOP ----
                case "STOP":
                    nsVideoPlayer.seek(0);
                    nsVideoPlayer.pause();
                    // nsVideoPlayer.close();
                    txtStatus.text = "Stopped";
                    break;
                //---- RW ----
                case "RW":
                    nsVideoPlayer.pause();
                    timerRW.start();
                    txtStatus.text = "Rewind";
                    break;
                //---- RW END ----
                case "RWEND":
                    nsVideoPlayer.resume();
                    timerRW.stop();
                    txtStatus.text = "Playing";
                    break;
                //---- FF ----
                case "FF":
                    timerFF.start();
                    txtStatus.text = "Fast Forward";
                    break;
                //---- FF END ----
                case "FFEND":
                    timerFF.stop();
                    txtStatus.text = "Playing";
                    break;
            }
        }

        private function runFF(event:TimerEvent):void {
            headPos = int((nsVideoPlayer.time) + seekRate);
            nsVideoPlayer.seek(headPos);
        }

        private function runRW(event:TimerEvent):void {
            headPos = int((nsVideoPlayer.time) - seekRate);
            nsVideoPlayer.seek(headPos);
        }

    }
}