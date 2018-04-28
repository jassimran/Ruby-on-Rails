class Profile < ActiveRecord::Base
  belongs_to :user

  validates :gender, inclusion: { in: %w(male female),
    message: "%{value} can only be male or female" }

  validate :check_first_name_for_gender, :check_first_or_last_name_null

  def check_first_name_for_gender
    if gender == "male" && first_name == "Sue"
      errors.add(:first_name, "Males can't have first name Sue")
    end
  end

  def check_first_or_last_name_null
    if first_name == nil && last_name == nil
      errors.add(:first_name, "First_name or last_name can be null but not both")
    end
  end

  def self.get_all_profiles(min_birth_year, max_birth_year)
    Profile.where("birth_year BETWEEN ? AND ?",min_birth_year,max_birth_year).order(birth_year: :asc).to_a

  end
end
