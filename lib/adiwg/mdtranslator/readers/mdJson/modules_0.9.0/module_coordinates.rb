# repack coordinates
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-07 original script
# 	Stan Smith 2013-11-13 added getDimension
#   Stan Smith 2014-05-23 added getLevels

module Md_Coordinates

	# repack coordinate array into single string for ISO
	def self.unpack(aCoords)
		s = ''
		i = 0
		coordCount = aCoords.length
		aCoords.each do |coord|
			if coord.kind_of?(Array)
				s = s + unpack(coord)
			else
				i += 1
				s = s + coord.to_s
				if i < coordCount
					s = s + ','
				end
				s = s + ' '
			end
		end

		return s
	end

	# get the number of dimensions in a coordinate array
	def self.getDimension(aCoords)
		if aCoords[0].kind_of?(Array)
			coordDim = getDimension(aCoords[0])
		else
			coordDim = aCoords.length
		end

		return coordDim
	end

	# get the number of levels in the coordinate array
	def self.getLevels(aCoords)
		i = 1
		if aCoords[0].kind_of?(Array)
			i = i + getLevels(aCoords[0])
		end
		return i
	end

end
