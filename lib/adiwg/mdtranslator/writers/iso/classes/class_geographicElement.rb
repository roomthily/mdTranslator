# ISO <<Class>> geographicElement {abstract}
# writer output in XML

# History:
# 	Stan Smith 2014-05-29 original script
#   Stan Smith 2014-05-30 added multi-point, multi-linestring, multi-polygon support
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'class_geographicBoundingBox'
require 'class_boundingPolygon'

class GeographicElement

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hGeoElement)

		# classes used by MD_Metadata
		geoBBoxClass = EX_GeographicBoundingBox.new(@xml)
		geoBPolyClass = EX_BoundingPolygon.new(@xml)

		geoType = hGeoElement[:elementGeometry][:geoType]
		case geoType
			when 'BoundingBox'
				geoBBoxClass.writeXML(hGeoElement)
			when 'Point', 'LineString', 'Polygon', 'MultiPoint', 'MultiLineString', 'MultiPolygon'
				geoBPolyClass.writeXML(hGeoElement)
			when 'MultiGeometry'
				geoBPolyClass.writeXML(hGeoElement)
		end

	end

end