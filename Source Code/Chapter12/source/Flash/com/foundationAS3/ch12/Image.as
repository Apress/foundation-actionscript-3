/**
 * Class to hold the metadata associated with an image used within this application.
 */
package com.foundationAS3.ch12 {

    public class Image {

        private var _name:String;
        private var _file:String;
        private var _thumb:String;

        /**
         * Constructor.
         *
         * @param  name  The name of the image to display.
         * @param  file  The path to the image for loading.
         * @param  thumb  The path to the thumbnail image for loading.
         */
        public function Image(name:String, file:String, thumb:String) {
            _name = name;
            _file = file;
            _thumb = thumb;
        }

        /**
         * Returns the name of the image.
         *
         * @returns  The name of the image to display.
         */
        public function get name():String {
            return _name;
        }

        /**
         * Returns the path to the image for loading.
         *
         * @returns  The path to the image for loading.
         */
        public function get file():String {
            return _file;
        }

        /**
         * Returns the path to the thumbnail image for loading.
         *
         * @returns  The path to the thumbnail image for loading.
         */
        public function get thumb():String {
            return _thumb;
        }

    }
}