# ISO <<Class>> CI_ResponsibleParty
# writer output in XML

# History:
# 	Stan Smith 2013-08-13 original script
#   Stan Smith 2014-05-14 modified for JSON schema 0.4.0
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'code_role'
require 'class_contact'

class CI_ResponsibleParty

	def initialize(xml)
		@xml = xml
	end

	def writeXML(rParty)

		# classes used in MD_Metadata
		ciContactClass = CI_Contact.new(@xml)
		ciRoleCode = CI_RoleCode.new(@xml)

		# search array of responsible party for matches in contact object
		rpID = rParty[:contactId]
		unless rpID.nil?
			hContact = ciContactClass.getContact(rpID)
			unless hContact.empty?
				@xml.tag!('gmd:CI_ResponsibleParty') do

					# responsible party - individual name
					s = hContact[:indName]
					if !s.nil?
						@xml.tag!('gmd:individualName') do
							@xml.tag!('gco:CharacterString', hContact[:indName])
						end
					elsif $showAllTags
						@xml.tag!('gmd:individualName')
					end

					# responsible party - organization name
					s = hContact[:orgName]
					if !s.nil?
						@xml.tag!('gmd:organisationName') do
							@xml.tag!('gco:CharacterString', hContact[:orgName])
						end
					elsif $showAllTags
						@xml.tag!('gmd:organisationName')
					end

					# responsible party - position name
					s = hContact[:position]
					if !s.nil?
						@xml.tag!('gmd:positionName') do
							@xml.tag!('gco:CharacterString', hContact[:position])
						end
					elsif $showAllTags
						@xml.tag!('gmd:positionName')
					end

					# responsible party - contact info
					# the following elements belong to CI_Contact
					if !(hContact[:phones].empty? &&
						 hContact[:address].empty? &&
						 hContact[:onlineRes].empty? &&
						 hContact[:contactInstructions].nil?)
						@xml.tag!('gmd:contactInfo') do
							ciContactClass.writeXML(hContact)
						end
					elsif $showAllTags
						@xml.tag!('gmd:contactInfo')
					end

					# responsible party - role - required
					s = rParty[:roleName]
					if s.nil?
						xml.tag!('gmd:role', {'gco:nilReason' => 'missing'})
					else
						@xml.tag! 'gmd:role' do
							ciRoleCode.writeXML(s)
						end
					end

				end
			end
		end

	end

end
