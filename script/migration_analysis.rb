LogBartOnlyIds = Logger.new(Rails.root.join("log","bart_only_ids.txt"))
LogTimeandCounts = Logger.new(Rails.root.join("log","time_and_counts.txt"))

# Select all people from model that are females and count them
def get_people(personmodel,name)
  log_progress("Searching for #{name} patients from :#{Time.now().strftime('%Y-%m-%d %H:%M:%S')}",true)
  people = personmodel.where(:voided => 0)
  log_progress("Finished searching for #{name} patients at:#{Time.now().strftime('%Y-%m-%d %H:%M:%S')}",true)
  log_progress("Found ##{personmodel.count} patients in #{name}",true)
  return people
end

#Get all people that are patients
def get_patients(people)
  patients = []
  people.each do |person|
    patients << person.patient
  end
  return patients
end


# Analyze demographics
def check_demographics
  
  bart_demographics =  build_demographics(get_people(Bart2Person,"BART 2.0"))
  log_progress("Finished buiding BART demographics at: #{Time.now().strftime('%Y-%m-%d %H:%M:%S')}",true)
  log_progress("There are : ##{bart_demographics.count} patient demographics in BART2",true)
  
  bart_only_ids = []
  bart_demographics.each do|key,value|
    next if key.blank?
      bart_only_ids << key
      log_progress("found in  > #{key}")
      LogBartOnlyIds.info key.to_s  
    end

  log_progress("##{bart_only_ids.count} national ids found in BART 2.0  only and not in Maternity",true)
  log_progress("Finished checking demographics at: #{Time.now().strftime('%Y-%m-%d %H:%M:%S')}",true)

end
# Get patients with identifiers only
def build_demographics(people)
  demographics = {}
  people.each do |person|
    next if person.blank?
    next if person.patient.blank?
    next if person.patient.patient_identifiers.first.blank?
    demographics[person.patient.patient_identifiers.first.identifier] = {"given_name" => person.names.first.given_name.titlecase,
                                                                         "family_name" => person.names.first.family_name.titlecase,
                                                                         "gender" => person.gender,
                                                                         "birthdate" => person.birthdate}
  end
 return demographics
end
# log status of script
def log_progress(message,log=false)
  puts ">>> " + message
  LogTimeandCounts.info message if log == true
end



#get_full_attribute(Bart2Person.last,"Occupation")
#build_dde_person(AncPerson.last)
check_demographics
#get_people(Bart2Person,"BART 2.0")