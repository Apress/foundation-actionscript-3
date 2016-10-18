package com.foundationAS3.ch14.irisreader {
    import com.adobe.xml.syndication.generic.*;

    import flash.events.EventDispatcher;

    import mx.events.PropertyChangeEvent;
    import mx.collections.ArrayCollection;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.http.HTTPService;

    [Bindable]
    public class Subscription extends EventDispatcher {

        private var _feedURL:String;
        private var _title:String;
        private var _url:String;
        private var _articles:ArrayCollection;
        private var _lastChecked:Date;
        private var _service:HTTPService;

        public function Subscription(feedURL:String) {
            _feedURL = feedURL;
            _articles = new ArrayCollection();
            _service = new HTTPService();
            _service.url = _feedURL;
            _service.resultFormat = HTTPService.RESULT_FORMAT_E4X;
            _service.addEventListener(ResultEvent.RESULT, onServiceResult);
            _service.addEventListener(FaultEvent.FAULT, onServiceFault);
            refresh();
        }

        private function onServiceResult(event:ResultEvent):void {
            var feed:IFeed = FeedFactory.getFeedByXML(event.result as XML);

            setTitle(feed.metadata.title);
            setURL(feed.metadata.link);

            for each (var item:IItem in feed.items) {
                if (lastChecked == null || item.date.getTime() > lastChecked.getTime()) {
                    articles.addItem(item);
                }
            }
            _lastChecked = new Date();
        }

        private function onServiceFault(event:FaultEvent):void {
        }

        public function refresh():void {
            _service.send();
        }

        private function notifyPropertyChange(name:String, oldValue:Object, value:Object):void {
            if (value !== oldValue) {
                dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, name, oldValue, value));
            }
        }

        private function setTitle(value:String):void {
            var oldValue:Object = _title;
            _title = value;
            notifyPropertyChange("title", oldValue, value);
        }

        private function setURL(value:String):void {
            var oldValue:Object = _url;
            _url = value;
            notifyPropertyChange("url", oldValue, value);
        }

        private function setArticles(value:ArrayCollection):void {
            var oldValue:Object = _articles;
            _articles = value;
            notifyPropertyChange("articles", oldValue, value);
        }

        private function setLastChecked(value:Date):void {
            var oldValue:Object = _lastChecked;
            _lastChecked = value;
            notifyPropertyChange("lastChecked", oldValue, value);
        }


        public function get feedURL():String {
            return _feedURL;
        }
    
        public function get title():String {
            return _title;
        }

        public function get url():String {
            return _url;
        }

        public function get articles():ArrayCollection {
            return _articles;
        }

        public function get lastChecked():Date {
            return _lastChecked;
        }

    }
}