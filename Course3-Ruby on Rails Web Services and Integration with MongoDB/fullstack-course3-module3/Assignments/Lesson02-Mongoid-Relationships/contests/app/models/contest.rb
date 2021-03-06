class Contest
  include Mongoid::Document
  include Mongoid::Timestamps::Updated

  field :name, type: String
  field :date, type: Date

  belongs_to :venue, class_name: 'Venue'
  embeds_many :entrants
  has_and_belongs_to_many :judges, class_name: 'Judge'
end
