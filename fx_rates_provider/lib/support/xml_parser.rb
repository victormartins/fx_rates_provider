# Adds XML parsing functionality to the consumer class.
module XMLParser
  require 'xmlsimple'

  def parse_xml(xml_string)
    XmlSimple.xml_in(xml_string)
  end
end
