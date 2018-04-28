class MedicalRecord
  include Mongoid::Document
  store_in collection: 'medical'
  field :conditions, type: Array

  belongs_to :racer, class_name: 'Racer'
  validates_presence_of :racer
end
