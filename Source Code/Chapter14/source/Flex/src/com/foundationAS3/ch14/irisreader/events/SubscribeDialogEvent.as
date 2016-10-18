package com.foundationAS3.ch14.irisreader.events {
    import flash.events.Event;

    public class SubscribeDialogEvent extends Event {

        public static const SUBSCRIBE:String = "subscribe";
        private var _feedURL:String;

        public function SubscribeDialogEvent(type:String,
                                             feedURL:String,
                                             bubbles:Boolean = false,
                                             cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
            _feedURL = feedURL;
        }

        override public function clone():Event {
            return new SubscribeDialogEvent(type, feedURL, bubbles, cancelable);
        }

        public function get feedURL():String {
            return _feedURL;
        }

    }
}