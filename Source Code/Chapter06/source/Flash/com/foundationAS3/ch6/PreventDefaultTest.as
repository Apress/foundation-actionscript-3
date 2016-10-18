package com.foundationAS3.ch6 {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.events.TextEvent;

    public class PreventDefaultTest extends Sprite {

        public function PreventDefaultTest() {
            var tf:TextField = new TextField();
            addChild(tf);

            tf.width = stage.stageWidth;
            tf.height = stage.stageWidth;
            tf.type = TextFieldType.INPUT;
            tf.wordWrap = true;

            tf.addEventListener(TextEvent.TEXT_INPUT, onTextFieldTextInput);
        }

        private function onTextFieldTextInput(event:TextEvent):void {
            var tf:TextField = event.target as TextField;
            if (tf.text.indexOf(event.text) > -1) {
                event.preventDefault();
            }
        }

    }
}