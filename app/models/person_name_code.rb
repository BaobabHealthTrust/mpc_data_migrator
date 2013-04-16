LogErr = Logger.new(Rails.root.join("log","error.txt"))
class PersonNameCode < ActiveRecord::Base
  
  belongs_to :person, :foreign_key => :id

  def self.create_name_code(person)
    found = self.find_by_person_id(person.id)
    
    return unless person.given_name.match(/[0-9]/).blank?
    return unless person.family_name.match(/[0-9]/).blank?

    return if person.given_name.blank?
    return if person.family_name.blank?

    unless person.family_name.match(/[[:punct:]]/).blank?
      return if person.family_name.match(/A'z/).blank?
      return if person.family_name.strip.length == 1
    end

    unless person.given_name.match(/[[:punct:]]/).blank?
      return if person.given_name.match(/A'z/).blank?
      return if person.given_name.strip.length == 1
    end

    if found.blank?
      self.create(:person_id => person.id,
                  :given_name_code => person.given_name.soundex,
                  :family_name_code => person.family_name.soundex)
    else
      found.given_name_code = person.given_name.soundex
      found.family_name_code = person.family_name.soundex
      found.save
    end
  end

  def self.rebuild_person_name_codes
    PersonNameCode.delete_all
    self.connection.execute('ALTER TABLE person_name_codes AUTO_INCREMENT = 1')
    people = Person.all
    people.each do |person|
      
      next if person.given_name.blank?
      next if person.family_name.blank?

      next unless person.given_name.match(/[0-9]/).blank?
      next unless person.family_name.match(/[0-9]/).blank?

      unless person.family_name.match(/[[:punct:]]/).blank?
        next if person.family_name.match(/A'z/).blank?
        next if person.family_name.strip.length == 1
      end

      unless person.given_name.match(/[[:punct:]]/).blank?
        next if person.given_name.match(/A'z/).blank?
        next if person.given_name.strip.length == 1
      end
      
      p = PersonNameCode.create(
        :person_id => person.id,
        :given_name_code => person.given_name.soundex,
        :family_name_code => person.family_name.soundex
      )

     puts p.inspect
     
    end
  end
  
end
