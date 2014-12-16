LogStatus = Logger.new(Rails.root.join("log","migration_status.txt"))
LogVer4 = Logger.new(Rails.root.join("log","version4_ids.txt"))
LogErr = Logger.new(Rails.root.join("log","error.txt"))
LogIds = Logger.new(Rails.root.join("log","migrated_ids.txt"))


site_code = SITE_CONFIG["site_id"]
class DdeMigration
def self.compare
apps = ["Bart2","Anc","Mat"]
apps.each do|app|

app_ids = eval("#{app}PatientIdentifier").where("LENGTH(identifier) = 6 AND identifier_type = 3")
total = app_ids.count
counter = 0
app_ids.each do |app_id|
    counter += 1
    national_id = NationalPatientIdentifier.where("value = ? AND person_id IS NULL AND voided = 0",app_id.identifier).first rescue nil
    if national_id.present?
      person = eval("#{app}Person").find(app_id.patient_id)
      person_params = self.build_dde_person(person)
      person_id = self.create_person_on_dde(person_params)
      if person_id
          national_id.person_id = person_id
          national_id.save!
      end
      puts "Remaining # #{total - counter} in #{app}"
      puts "Created person" 
    else
         puts "Remaining # #{total - counter} in #{app}"
    end
end
end
end

def self.create_person_on_dde(params)
  passed_national_id = (params['person']['data']['patient']['identifiers']['old_identification_number'])
  national_id = passed_national_id.gsub('-','').strip unless passed_national_id.blank?
  version = Guid.new.to_s
  person_hash = params['person'].merge(
                         {:creator_site_id => Site.current_id ,
                         :given_name => params["person"]["data"]["names"]["given_name"] ,
                         :family_name => params["person"]["data"]["names"]["family_name"] ,
                         :gender => params["person"]["data"]["gender"] ,
                         :birthdate => params["person"]["data"]["birthdate"] ,
                         :creator_id => 1,
                         :birthdate_estimated => params["person"]["data"]["birthdate_estimated"],
                         :version_number => version,
                         :remote_version_number => version }
                        )
   
    @person = Person.create(person_hash)
    
     if @person
        unless passed_national_id.blank?
          legacy_national_id = LegacyNationalIds.new()
          legacy_national_id.person_id = @person.id
          legacy_national_id.value = national_id
          legacy_national_id.save! rescue LogErr.error "passed national id " + passed_national_id.to_s
        end
        self.log_progress("migrated ***#{national_id}***")
        LogIds.info national_id.to_s
        
     else
       LogErr.error "passed national id " + passed_national_id.to_s
     end
    return @person.id 
end



def self.build_dde_person(person)
  current_person = {"person" => {
              "birthdate_estimated" => (person.birthdate_estimated rescue nil),
              "gender" => (person.gender rescue nil),
              "birthdate" => (person.birthdate rescue nil),
              "birth_year" => (person.birthdate.to_date.year rescue nil),
              "birth_month" => (person.birthdate.to_date.month rescue nil),
              "birth_day" => (person.birthdate.to_date.day rescue nil),
              "names" => {
                "given_name" => person.names.first.given_name,
                "family_name" => person.names.first.family_name
              },
              "patient" => {
                "identifiers" => {
                  "old_identification_number" => person.patient.patient_identifiers.first.identifier
                }
              },
              "attributes" => {
                "occupation" => (self.get_full_attribute(person, "Occupation") rescue ""),
                "cell_phone_number" => (self.get_full_attribute(person, "Cell Phone Number") rescue ""),
                "citizenship" => (self.get_full_attribute(person, "Citizenship") rescue ""),
                "race" => (self.get_full_attribute(person, "Race") rescue "")
              },
              "addresses" => {
                "address1" => (person.addresses.last.address1 rescue ""),
                "city_village" => (person.addresses.last.city_village rescue ""),
                "address2" => (person.addresses.last.address2 rescue ""),
                "state_province" => (person.addresses.last.state_province rescue ""),
                "county_district" => (person.addresses.last.county_district rescue ""),
                "neighborhood_cell" => (person.addresses.last.neighborhood_cell rescue "")
              }
            }
          }
  return self.build_person_for_dde(current_person)
end

def self.build_person_for_dde(params)
	  address_params = params["person"]["addresses"]
		names_params = params["person"]["names"]
		patient_params = params["person"]["patient"]
    birthday_params = params["person"]
		params_to_process = params.reject{|key,value|
      key.match(/identifiers|addresses|patient|names|relation|cell_phone_number|home_phone_number|office_phone_number|agrees_to_be_visited_for_TB_therapy|agrees_phone_text_for_TB_therapy/)
    }
		birthday_params = params_to_process["person"].reject{|key,value| key.match(/gender/) }
		person_params = params_to_process["person"].reject{|key,value| key.match(/birth_|age_estimate|occupation/) }


		if person_params["gender"].to_s == "Female"
      person_params["gender"] = 'F'
		elsif person_params["gender"].to_s == "Male"
      person_params["gender"] = 'M'
		end

		unless birthday_params.empty?
		  if birthday_params["birth_year"] == "Unknown"
			  birthdate = Date.new(Date.today.year - birthday_params["age_estimate"].to_i, 7, 1)
        birthdate_estimated = 1
		  else
			  year = birthday_params["birth_year"]
        month = birthday_params["birth_month"]
        day = birthday_params["birth_day"]

        month_i = (month || 0).to_i
        month_i = Date::MONTHNAMES.index(month) if month_i == 0 || month_i.blank?
        month_i = Date::ABBR_MONTHNAMES.index(month) if month_i == 0 || month_i.blank?

        if month_i == 0 || month == "Unknown"
          birthdate = Date.new(year.to_i,7,1)
          birthdate_estimated = 1
        elsif day.blank? || day == "Unknown" || day == 0
          birthdate = Date.new(year.to_i,month_i,15)
          birthdate_estimated = 1
        else
          birthdate = Date.new(year.to_i,month_i,day.to_i)
          birthdate_estimated = 0
        end
		  end
    else
      birthdate_estimated = 0
		end

    passed_params = {"person"=>
        {"data" =>
          {"addresses"=>
            {"state_province"=> (address_params["state_province"] rescue ""),
            "address2"=> (address_params["address2"] rescue ""),
            "address1"=> (address_params["address1"] rescue ""),
            "city_village"=> (address_params["city_village"] rescue ""),
            "county_district"=> (address_params["county_district"] rescue ""),
            "neighborhood_cell" =>(address_params["neighborhood_cell"] rescue "")
          },
          "attributes"=>
            {"occupation"=> (params["person"]["occupation"] rescue ""),
            "cell_phone_number" => (params["person"]["cell_phone_number"] rescue ""),
            "citizenship" => (params["person"]["citizenship"] rescue ""),
            "race" => (params["person"]["race"] rescue "")
          },
          "patient"=>
            {"identifiers"=>
              {"old_identification_number" => params["person"]["patient"]["identifiers"]["old_identification_number"]}},
          "gender"=> person_params["gender"],
          "birthdate"=> birthdate,
          "birthdate_estimated"=> birthdate_estimated ,
          "names"=>{"family_name"=> names_params["family_name"],
            "given_name"=> names_params["given_name"]
          }
        }
      }
    }
   return passed_params
end

def self.get_full_attribute(person,attribute)
    attribute_value = person.person_attributes.find(:first,:conditions =>["voided = 0 AND person_attribute_type_id = ? AND person_id = ?",
    Bart2PersonAttributeType.find_by_name(attribute).id,person.id]).value rescue nil
    return attribute_value
end

def self.log_progress(message,log=false)
  puts ">>> " + message
  if log == true
    LogStatus.info message
    LogStatus.info "#" * message.length
  end
end

compare

end







      
      



      
