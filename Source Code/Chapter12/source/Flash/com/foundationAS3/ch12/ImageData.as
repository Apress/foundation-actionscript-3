/**
 * Class that loads and parses image data for display within the application.
 */
package com.foundationAS3.ch12 {
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    public class ImageData extends EventDispatcher {

        // the file containing the image data that will load upon initialization of the application
        private static const DATA_FILE:String = "images.xml";

        private var _data:Array;

        /**
         * Handler for when the XML successfully loads, at which point data is parsed and placed in Image instances.
         *
         * @param  event  The event fired by URLLoader.
         */
        private function onXMLLoaded(event:Event):void {
            _data = [];
            var loader:URLLoader = event.target as URLLoader;
            var xml:XML = new XML(loader.data);
            var images:XMLList = xml.child("image");
            var numImages:uint = images.length();
            var image:XML;
            for (var i:uint = 0; i < numImages; i++) {
                image = images[i] as XML;
                _data.push(
                        new Image(
                                image.child("name").toString(),
                                image.child("file").toString(),
                                image.child("thumb").toString()
                        )
                );
            }
            dispatchEvent(new Event(Event.COMPLETE));
        }

        /**
         * Loads the XML file containing the image data.
         */
        public function load():void {
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, onXMLLoaded);
            loader.load(new URLRequest(DATA_FILE));
        }

        /**
         * Returns an array of the image data, with each item containing a label and data (Image instance).
         *
         * @returns  An array containing the image data to be used with lists needing labels for items.
         */
        public function getNameData():Array {
            var nameData:Array = [];
            var numImages:uint = _data.length;
            var image:Image;
            for (var i:uint = 0; i < numImages; i++) {
                image = _data[i] as Image;
                nameData.push({label: image.name, data: image});
            }
            return nameData;
        }

        /**
         * Returns an array of the image data, with each item containing a label (empty) source, and data (Image instance).
         *
         * @returns  An array containing the image data to be used with lists needing source images for items.
         */
        public function getThumbData():Array {
            var thumbData:Array = [];
            var numImages:uint = _data.length;
            var image:Image;
            for (var i:uint = 0; i < numImages; i++) {
                image = _data[i] as Image;
                thumbData.push({label: "", source: image.thumb, data: image});
            }
            return thumbData;
        }

    }
}