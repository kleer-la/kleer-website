require 'curb'
require 'json'
require 'open-uri'

class CrmConnector

	CRM_URL = "https://kleer.capsulecrm.com/api"

	def self.subscribe_person( email, fname, lname, influence_zone_tag )

		crm_ids = CrmConnector::get_crm_ids(email)

	  if crm_ids.size == 0
		  new_id = CrmConnector::create_person( email, fname, lname )
		  CrmConnector::add_crm_tag new_id, influence_zone_tag
			CrmConnector::add_crm_tag new_id, 'OR-Website'
	  else
	   	crm_ids.each do |crm_id|
	 			CrmConnector::add_crm_tag crm_id, 'OR-Website'
  		end
	  end

	end

	def self.create_person( email, fname, lname )
		c = CrmConnector::create_crm_curl(CRM_URL + "/person")

		c.headers['Content-Type'] = 'application/xml'

		new_crm_person_xml = "<?xml version='1.0' encoding='UTF-8' standalone='yes'?>" +
					 "<person>" +
						"<firstName>#{fname}</firstName>" +
						"<lastName>#{lname}</lastName>" +
						"<contacts>" +
							"<email>" +
								"<emailAddress>#{email}</emailAddress>" +
							"</email>" +
						"</contacts>" +
					 "</person>"

		c.http_post( new_crm_person_xml )

		redirect_url = c.header_str.match(/Location: (.*)/).to_s
		from_index = redirect_url.rindex("/")+1
		to_index = redirect_url.length-1
		new_id = redirect_url[from_index..to_index].strip

		new_id
	end

	def self.add_crm_tag(id_crm, tag)
  	  if !tag.nil? && tag != ""
		  	encoded_tag = URI::encode(tag)
		  	c = CrmConnector::create_crm_curl(CRM_URL + "/party/#{id_crm}/tag/#{encoded_tag}")
		  	c.http_post
	  end
  end

	def self.get_crm_ids(email)
	 	crm_ids = Array.new

		encoded_email = URI::encode(email)
		c = CrmConnector::create_crm_curl(CRM_URL + "/party?email=#{encoded_email}")
		c.headers["Accept"] = "application/json"
		c.http_get
		response = JSON.parse( c.body_str )

		if response["parties"]["@size"].to_i > 0

			if response["parties"]["person"].class == Hash
			  crm_ids << response["parties"]["person"]["id"]

			elsif response["parties"]["person"].class == Array
			  response["parties"]["person"].each do |person|
			    crm_ids << person["id"]
			  end
			end
		end

		crm_ids
	end

	def self.create_crm_curl(url)
		c = Curl::Easy.new(url)

		c.http_auth_types = :basic
		c.username = ENV["KLEER_CRM_TOKEN"]
		c.password = ENV["KLEER_CRM_PASSWORD"]

		c
	end

end
