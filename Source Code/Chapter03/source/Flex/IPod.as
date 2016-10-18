package {

    public class IPod {

        public var name:String;
        public var volumeLevel:uint;
        public var shuffle:Boolean;
        public var tracks:Array;

        private var _serialNumber:String;
        private var _currentTrack:uint;

        // Constructor
        public function IPod(serialNumber:String,
                             name:String = "",
                             volumeLevel:uint = 10,
                             shuffle:Boolean = false) {
            _serialNumber = serialNumber;
            this.name = name;
            this.volumeLevel = volumeLevel;
            this.shuffle = shuffle;
            _currentTrack = 0;
            tracks = new Array();
        }

        // Plays a track
        public function play():void {
            trace("Playing: " + tracks[currentTrack]);
        }

        // Moves to the next track
        public function next():void {
            if (shuffle) {
                // Chooses a random track
                currentTrack = Math.floor(Math.random() * tracks.length);
            } else {
                // If last track has been reached, move to the first
                if (currentTrack == tracks.length - 1) {
                    currentTrack = 0;
                } else {
                    currentTrack++;
                }
            }
            play();
        }

        // Returns current track
        public function get currentTrack():uint {
            return _currentTrack;
        }

        // Sets the current track to play
        public function set currentTrack(value:uint):void {
            // Ensures value is within range 0 to the number of tracks
            value = Math.max(0, value);
            value = Math.min(value, tracks.length - 1);
            _currentTrack = value;
        }

        // Returns the serial number of the IPod
        public function get serialNumber():String {
            return _serialNumber;
        }

    }
}