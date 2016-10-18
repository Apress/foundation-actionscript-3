package {

    public class PhotoIPod extends IPod {

        public var photos:Array;
        public var currentPhoto:uint;

        // Constructor
        public function PhotoIPod(serialNumber:String,
                                  name:String = "",
                                  volumeLevel:uint = 10,
                                  shuffle:Boolean = false) {
            super(
                    serialNumber,
                    name,
                    volumeLevel,
                    shuffle
            );
            photos = new Array();
            currentPhoto = 0;
        }

        // Method to display a photo (not implemented)
        public function showPhoto():void {
            trace("Showing: " + photos[currentPhoto]);
        }

        // Method to move to the next photo
        public function nextPhoto():void {
            // If last photo has been reached, move to the first
            if (currentPhoto == photos.length - 1) {
                currentPhoto = 0;
            } else {
                currentPhoto++;
            }
            showPhoto();
        }

    }
}