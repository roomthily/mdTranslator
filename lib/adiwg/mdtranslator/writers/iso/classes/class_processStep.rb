# ISO <<Class>> LI_ProcessStep
# writer output in XML

# History:
# 	Stan Smith 2013-11-20 original script
#   Stan Smith 2014-07-09 modify require statements to function in RubyGem structure

require 'module_dateTimeFun'
require 'class_responsibleParty'

class LI_ProcessStep

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hProcessStep)

		# classes used
		rPartyClass = CI_ResponsibleParty.new(@xml)

		# process step - id
		attributes = {}
		s = hProcessStep[:stepId]
		unless s.nil?
			attributes['id' => s]
		end
		@xml.tag!('gmd:LI_ProcessStep',attributes) do

			# process step - description - required
			s = hProcessStep[:stepDescription]
			if s.nil?
				@xml.tag!('gmd:description',{'gco:nilReason'=>'missing'})
			else
				@xml.tag!('gmd:description') do
					@xml.tag!('gco:CharacterString',s)
				end
			end

			# process step - rationale
			s = hProcessStep[:stepRationale]
			if !s.nil?
				@xml.tag!('gmd:rationale') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showAllTags
				@xml.tag!('gmd:rationale')
			end

			# process step - datetime
			hDateTime = hProcessStep[:stepDateTime]
			if !hDateTime.empty?
				date = hDateTime[:dateTime]
				dateResolution = hDateTime[:dateResolution]
				s = AdiwgDateTimeFun.stringDateTimeFromDateTime(date,dateResolution)
				if s != 'ERROR'
					@xml.tag!('gmd:dateTime') do
						@xml.tag!('gco:DateTime',s)
					end
				end
			elsif $showAllTags
				@xml.tag!('gmd:dateTime')
			end

			# process step - processor - CI_ResponsibleParty
			aProcessors = hProcessStep[:stepProcessors]
			if !aProcessors.empty?
				aProcessors.each do |rParty|
					@xml.tag!('gmd:processor') do
						rPartyClass.writeXML(rParty)
					end
				end
			elsif $showAllTags
				@xml.tag!('gmd:processor')
			end

		end

	end

end
