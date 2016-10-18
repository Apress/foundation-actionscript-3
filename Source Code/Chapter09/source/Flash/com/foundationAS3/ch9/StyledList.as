/**
 * Class to provide a list and buttons/fields that allow adding, editing and removing of items from the list.
 */
package com.foundationAS3.ch9 {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextFormat;

    import fl.controls.Button;
    import fl.controls.List;
    import fl.controls.TextInput;
    import fl.managers.StyleManager;

    public class StyledList extends Sprite {

        /**
         * Constructor.
         */
        public function StyledList() {
            init();
        }

        /**
         * Initialization script.
         */
        private function init():void {
            setStyles();
            addListeners();
        }

        /**
         * Sets graphic styles for the components.
         */
        private function setStyles():void {
            var format:TextFormat = new TextFormat("Arial", 10, 0x01578F);
            StyleManager.setStyle("textFormat", format);
            format = new TextFormat("Arial", 12, 0x01578F);
            StyleManager.setComponentStyle(Button, "textFormat", format);
            format = new TextFormat("Arial", 12, 0x999999);
            StyleManager.setComponentStyle(Button, "disabledTextFormat", format);
            format = new TextFormat("Arial", 12, 0xFF0000);
            deleteName_bn.setStyle("textFormat", format);
        }

        /**
         * Adds the necessary component event listeners.
         */
        private function addListeners():void {
            addName_bn.addEventListener(MouseEvent.CLICK, onAddName);
            addName_ti.addEventListener(Event.CHANGE, onNameEnter);
            deleteName_bn.addEventListener(MouseEvent.CLICK, onDeleteName);
            editName_ti.addEventListener(Event.CHANGE, onNameChange);
            names_li.addEventListener(Event.CHANGE, onNameSelected);
            addEventListener(Event.ENTER_FRAME, onNextFrame);
        }

        /**
         * Handler for when the next frame is reached after initialization, when buttons can be disabled.
         *
         * @param  event  The event fired by this instance.
         */
        private function onNextFrame(event:Event):void {
            removeEventListener(Event.ENTER_FRAME, onNextFrame);
            addName_bn.enabled = false;
            deleteName_bn.enabled = false;
            editName_ti.enabled = false;
        }

        /**
         * Handler for when the add name button is clicked, adds item to list.
         *
         * @param  event  The event fired by the add name Button.
         */
        private function onAddName(event:MouseEvent):void {
            var newItem:Object = {label: addName_ti.text};
            names_li.dataProvider.addItem(newItem);
            addName_ti.text = "";
            addName_bn.enabled = false;
        }

        /**
         * Handler for when text is entered into the add name textfield, enables the add name button.
         *
         * @param  event  The event fired by the add name TextField.
         */
        private function onNameEnter(event:Event):void {
            addName_bn.enabled = addName_ti.text.length > 0;
        }

        /**
         * Handler for when the delete name button is clicked, removes the list item.
         *
         * @param  event  The event fired by the delete name Button.
         */
        private function onDeleteName(event:MouseEvent):void {
            names_li.dataProvider.removeItemAt(names_li.selectedIndex);
            deleteName_bn.enabled = false;
            editName_ti.text = "";
            editName_ti.enabled = false;
        }

        /**
         * Handler for when text is changed into the edit name textfield, alters the item in the list.
         *
         * @param  event  The event fired by the edit name TextField.
         */
        private function onNameChange(event:Event):void {
            var newItem:Object = {label: editName_ti.text};
            names_li.dataProvider.replaceItemAt(newItem, names_li.selectedIndex);
        }

        /**
         * Handler for when an item is selected in the list, populates fields and enables buttons.
         *
         * @param  event  The event fired by the names List.
         */
        private function onNameSelected(event:Event):void {
            editName_ti.text = names_li.selectedItem.label;
            editName_ti.enabled = true;
            deleteName_bn.enabled = true;
        }

    }
}