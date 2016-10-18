package com.foundationAS3.ch7 {
    import flash.events.Event;

    public class MediaControlEvent extends flash.events.Event {
        public static const CONTROL_TYPE:String = "headControl";
        public var command:String;

        public function MediaControlEvent(command:String) {
            super(CONTROL_TYPE);
            this.command = command;
        }

    }
}