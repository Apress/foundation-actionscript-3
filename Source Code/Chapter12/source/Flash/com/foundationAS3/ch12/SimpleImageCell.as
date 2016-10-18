/**
 * Class that alters the imagePadding setting for ImageCell.
 */
package com.foundationAS3.ch12 {
    import fl.controls.listClasses.ImageCell;

    public class SimpleImageCell extends ImageCell {

        /**
         * Constructor.
         */
        public function SimpleImageCell() {
            super();
            setStyle("imagePadding", 5);
        }

    }
}