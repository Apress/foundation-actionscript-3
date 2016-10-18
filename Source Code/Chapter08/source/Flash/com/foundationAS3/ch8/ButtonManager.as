package com.foundationAS3.ch8 {
    import flash.net.*;
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.EventDispatcher;
    import flash.events.Event;

    import com.foundationAS3.ch8.MediaControlEvent;

    public class ButtonManager extends Sprite {
        private var butRW:SimpleButton;
        private var butPlay:SimpleButton;
        private var butPause:SimpleButton;
        private var butStop:SimpleButton;
        private var butFF:SimpleButton;
        private var eventDispatcherButton:EventDispatcher;
        private var pauseOn:Boolean = false;

        // Simply instantiate your button manager class by passing it the names of your Rewind,
        // Play, Pause, Stop and fast Forward button instances
        public function ButtonManager(butRW:SimpleButton,
                                      butPlay:SimpleButton,
                                      butPause:SimpleButton,
                                      butStop:SimpleButton,
                                      butFF:SimpleButton) {
            this.butRW = butRW;
            this.butPlay = butPlay;
            this.butPause = butPause;
            this.butStop = butStop;
            this.butFF = butFF;

            // Add button listeners
            butRW.addEventListener(MouseEvent.MOUSE_DOWN, doRewind);
            butRW.addEventListener(MouseEvent.CLICK, stopRewind);
            butPlay.addEventListener(MouseEvent.MOUSE_DOWN, doPlay);
            butFF.addEventListener(MouseEvent.MOUSE_DOWN, doFastForward);
            butFF.addEventListener(MouseEvent.CLICK, stopFastForward);

            butRW.enabled = false;
            butFF.enabled = false;
            butPause.enabled = false;
            butStop.enabled = false;
        }

        // This function adds any external objects to the listener list for the mediaControl event
        public function addMediaControlListener(funcObj:Function):void {
            addEventListener(MediaControlEvent.CONTROL_TYPE, funcObj);
        }

        private function doRewind(event:MouseEvent):void {
            dispatchEvent(new MediaControlEvent("RW"));
        }

        private function stopRewind(event:MouseEvent):void {
            dispatchEvent(new MediaControlEvent("RWEND"));
        }

        private function doPlay(event:MouseEvent):void {
            butPause.addEventListener(MouseEvent.MOUSE_DOWN, doPause);
            butPause.enabled = true;
            butStop.addEventListener(MouseEvent.MOUSE_DOWN, doStop);
            butStop.enabled = true;
            butFF.enabled = true;
            butRW.enabled = true;
            dispatchEvent(new MediaControlEvent("PLAY"));
        }

        private function doPause(event:MouseEvent):void {
            if (pauseOn) {
                butRW.enabled = true;
                butFF.enabled = true;
                butPlay.enabled = true;
                butStop.enabled = true;
                pauseOn = false;
            } else {
                butRW.enabled = false;
                butFF.enabled = false;
                butPlay.enabled = false;
                butStop.enabled = false;
                pauseOn = true;
            }
            dispatchEvent(new MediaControlEvent("PAUSE"));
        }

        private function doStop(event:MouseEvent):void {
            butPause.removeEventListener(MouseEvent.MOUSE_DOWN, doPause);
            butPause.enabled = false;
            dispatchEvent(new MediaControlEvent("STOP"));
        }

        private function doFastForward(event:MouseEvent):void {
            dispatchEvent(new MediaControlEvent("FF"));
        }

        private function stopFastForward(event:MouseEvent):void {
            dispatchEvent(new MediaControlEvent("FFEND"));
        }

    }
}
