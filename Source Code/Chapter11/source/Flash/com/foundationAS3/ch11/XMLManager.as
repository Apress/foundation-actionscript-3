package  com.foundationAS3.ch11 {
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.events.Event;

    class XMLManager {
        private var ulXml:URLLoader;
        private var urXml:URLRequest;
        private var xmlEPG:XML;

        public function XMLManager() {
            // Connect to the XML file
            urXml = new URLRequest("EPG.xml");
            // Instantiate loader
            ulXml = new URLLoader();
            // Add event listener for load complete
            ulXml.addEventListener(Event.COMPLETE, xmlLoaded);
            // Load XML
            ulXml.load(urXml);
        }

        private function xmlLoaded(evt:Event):void {
            xmlEPG = new XML(ulXml.data);
            trace(xmlEPG.toXMLString());
            // trace("First Child = "+xmlEPG.name());
            // trace("First Child = "+xmlEPG.child(0).attributes());
            // trace("First Child = "+xmlEPG.Channel.Program.attributes());
            // trace("Children = "+xmlEPG.Channel[0].children());
            // trace("Children LENGTH = "+xmlEPG.Channel[0].children.length);
            // trace("Children ITV = "+xmlEPG.Channel[1].children());
            // var xmlITV:XMLList = xmlEPG.Channel[1].children();
            var xmlChannels:XMLList = xmlEPG.Channel.@id;
            trace("Channels are " + xmlChannels);
            /*
             var channel:String;
             for each (channel in xmlChannels){
             trace("channel XXX "+channel);
             var xmlSixAM:XMLList = xmlEPG.*.Program.(@starttime == "6:00").@id;
             }
             */
            // var xmlITV:XMLList = xmlEPG.Channel.(@id == "ITV");
            // var xmlITV:XMLList = xmlEPG.Channel.(@id == "ITV").Program.(@starttime == "6:00").@id;
            // var xmlSixAM:XMLList = xmlEPG.*.Program.(@starttime == "6:00").@id;
            // var xmlString:String = xmlEPG.Channel.(@id == "ITV").Day.(@id == "Monday").Program.(@id == "Breakfast");
            // trace("Breakfast text = "+xmlString);
            // var xmlString:String = xmlEPG.Channel.(@id == “ITV”).Day.Program.(@id == "Breakfast");
            // trace("Breakfast text = "+xmlString);
            var xmlTest:XML = <Channel id="BBC2">
                <Day id="Monday">
                    <Program id="Open University" starttime="6:00">Are you clever?</Program>
                </Day>
            </Channel>;
            xmlEPG.Channel;
            trace(xmlEPG.toXMLString());
        }

    }
}