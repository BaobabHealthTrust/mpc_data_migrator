site_code = SITE_CONFIG["site_id"]
master_ids = MasterNationalPatientIdentifier.where(:pulled => true, :assigner_site_id => site_code)
