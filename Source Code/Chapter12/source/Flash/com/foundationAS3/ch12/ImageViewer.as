/**
 * Main application class for loading and viewing of images based on the display within two lists, populated by XML.
 *               This class is the document class for imageViewer.fla, which places and names the UI components required for the UI.
 */
package com.foundationAS3.ch12 {
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filters.DropShadowFilter;
    import flash.text.TextFormat;

    import fl.containers.ScrollPane;
    import fl.controls.Label;
    import fl.controls.List;
    import fl.controls.RadioButton;
    import fl.controls.Slider;
    import fl.controls.TileList;
    import fl.data.DataProvider;
    import fl.managers.StyleManager;

    public class ImageViewer extends Sprite {

        private var _imagePane_sp:ScrollPane;
        private var _title_lbl:Label;
        private var _thumbnails_rb:RadioButton;
        private var _names_rb:RadioButton;
        private var _thumbnails_tl:TileList;
        private var _names_li:List;
        private var _zoom_sl:Slider;
        private var _images:ImageData;

        /**
         * Constructor.
         */
        public function ImageViewer() {
            init();
        }

        /**
         * Initialization script.
         */
        private function init():void {
            assignComponentReferences();
            configureComponents();
            drawListShadow();
            assignHandlers();
            loadImageData();
        }

        /**
         * Assigns components from FLA to member variables within this class in order to allow for code hinting and compile time errors.
         */
        private function assignComponentReferences():void {
            _imagePane_sp = imagePane_sp;
            _title_lbl = title_lbl;
            _thumbnails_rb = thumbnails_rb;
            _names_rb = names_rb;
            _thumbnails_tl = thumbnails_tl;
            _names_li = names_li;
            _zoom_sl = zoom_sl;
        }

        /**
         * Sets properties for components that were not settable in the Flash IDE.
         */
        private function configureComponents():void {
            _thumbnails_tl.columnWidth = 85;
            _thumbnails_tl.rowHeight = 70;
            _names_rb.selected = true;
            _title_lbl.setStyle("textFormat", new TextFormat("Arial", 14));
            StyleManager.setComponentStyle(TileList, "cellRenderer", SimpleImageCell);
        }

        /**
         * Draws a drop shadow beneath the list components to match visually the scroll pane.
         */
        private function drawListShadow():void {
            var shadowShape:Shape = new Shape();
            shadowShape.x = _names_li.x;
            shadowShape.y = _names_li.y;
            shadowShape.graphics.beginFill(0);
            shadowShape.graphics.drawRect(0, 0, _names_li.width, _names_li.height);
            shadowShape.graphics.endFill();
            shadowShape.filters = [
                new DropShadowFilter(2, 90, 0, 1, 4, 4, .7, 1, false, false, true)
            ];
            addChildAt(shadowShape, 0);
        }

        /**
         * Adds the event listeners for the components.
         */
        private function assignHandlers():void {
            _thumbnails_rb.addEventListener(Event.CHANGE, onListViewChange);
            _thumbnails_tl.addEventListener(Event.CHANGE, onImageSelected);
            _names_li.addEventListener(Event.CHANGE, onImageSelected);
            _zoom_sl.addEventListener(Event.CHANGE, onZoom);
        }

        /**
         * Instantiates ImageData, which loads in the data for the images to display.
         */
        private function loadImageData():void {
            _images = new ImageData();
            _images.addEventListener(Event.COMPLETE, onDataLoaded);
            _images.load();
        }

        /**
         * Handler for when the ImageData instance has loaded its data.
         *
         * @param  event  The event fired by ImageData.
         */
        private function onDataLoaded(event:Event):void {
            _images.removeEventListener(Event.COMPLETE, onDataLoaded);
            _thumbnails_tl.dataProvider = new DataProvider(_images.getThumbData());
            _names_li.dataProvider = new DataProvider(_images.getNameData());
        }

        /**
         * Handler for when a radio button is clicked to toggle the visible list.
         *
         * @param  event  The event fired by RadioButton.
         */
        private function onListViewChange(event:Event):void {
            _thumbnails_tl.visible = _thumbnails_rb.selected;
            _names_li.visible = !_thumbnails_rb.selected;
        }

        /**
         * Handler for when an image is selected from one of the lists.
         *
         * @param  event  The event fired by List or TileList.
         */
        private function onImageSelected(event:Event):void {
            var image:Image = event.target.selectedItem.data as Image;
            var index:int = event.target.selectedIndex;
            _thumbnails_tl.selectedIndex = index;
            _names_li.selectedIndex = index;
            _zoom_sl.value = 1;
            _title_lbl.text = image.name;
            var imageHolder:ImageHolder = _imagePane_sp.source as ImageHolder;
            if (imageHolder) {
                imageHolder.removeEventListener(Event.COMPLETE, onImageLoaded);
            }
            imageHolder = new ImageHolder(image.file);
            imageHolder.addEventListener(Event.COMPLETE, onImageLoaded);
            _imagePane_sp.source = imageHolder;
        }

        /**
         * Handler for when an image has been loaded by ImageHolder, allowing for refreshing of the scroll pane.
         *
         * @param  event  The event fired by ImageHolder.
         */
        private function onImageLoaded(event:Event):void {
            var imageHolder:ImageHolder = event.target as ImageHolder;
            imageHolder.removeEventListener(Event.COMPLETE, onImageLoaded);
            _imagePane_sp.refreshPane();
        }

        /**
         * Handler for when the zoom slider is dragged, causing the image to be scaled within the scroll pane.
         *
         * @param  event  The event fired by Slider.
         */
        private function onZoom(event:Event):void {
            if (_imagePane_sp.content) {
                _imagePane_sp.content.scaleX = _imagePane_sp.content.scaleY = _zoom_sl.value;
                _imagePane_sp.update();
            }
        }

    }
}