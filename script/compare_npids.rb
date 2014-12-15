site_code = SITE_CONFIG["site_id"]
master_ids = MasterNationalPatientIdentifier.where(:pulled => true, :assigner_site_id => site_code)
master_ids.each do |master_id|
    national_id = NationalPatientIdentifier.find_by_value(master_id.value) rescue nil
    if national_id.blank?
        npid = NationalPatientIdentifier.new
        npid.value = master_id.value
        npid.assigner_site_id = master_id.assigner_site_id
        npid.assigned_at = Date.today
        npid.save
        puts "Created npid"
    else
        puts "Npid already found"
    end
end
