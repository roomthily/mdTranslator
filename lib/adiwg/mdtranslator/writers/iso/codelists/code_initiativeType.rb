# ISO <<CodeLists>> gmd:DS_InitiativeTypeCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2014-05-21 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered

class DS_InitiativeTypeCode
	def initialize(xml)
		@xml = xml
	end

	def writeXML(codeName)
		case(codeName)
			when 'campaign' then codeID = '001'
			when 'collection' then codeID = '002'
			when 'exercise' then codeID = '003'
			when 'experiment' then codeID = '004'
			when 'investigation' then codeID = '005'
			else
				codeID = 'non-ISO codeName'
		end

		# write xml
		@xml.tag!('gmd:DS_InitiativeTypeCode',{:codeList=>'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#DS_InitiativeTypeCode',
											 :codeListValue=>"#{codeName}",
											 :codeSpace=>"#{codeID}"})
	end

end





