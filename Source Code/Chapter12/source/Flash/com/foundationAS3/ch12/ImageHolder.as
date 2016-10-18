/**
 * Class for loading and fading in an image from an external file.
 */
package com.foundationAS3.ch12 {
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLRequest;

    public class ImageHolder extends Sprite {

        /**
         * Constructor.
         *
         * @param  file  The path to the image file to load.
         */
        public function ImageHolder(file:String) {
            alpha = 0;
            loadImage(file);
        }

        /**
         * Loads an image from an external file.
         *
         * @param  file  The path to the image file to load.
         */
        private function loadImage(file:String):void {
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
            loader.load(new URLRequest(file));
        }

        /**
         * Handler for when an image has successfully loaded.
         *
         * @param  event  The event fired by LoaderInfo.
         */
        private function onImageLoaded(event:Event):void {
            var loaderInfo:LoaderInfo = event.target as LoaderInfo;
            loaderInfo.removeEventListener(Event.COMPLETE, onImageLoaded);
            addChild(loaderInfo.content);
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
            dispatchEvent(new Event(Event.COMPLETE));
        }

        /**
         * Handler for when the screen updates each frame, used for fading in the image.
         *
         * @param  event  The event fired by this instance.
         */
        private function onEnterFrame(event:Event):void {
            alpha += 0.1;
            if (alpha >= 1) {
                alpha = 1;
                removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            }
        }

    }
}