class AddressComponent
  include ActiveModel::Model

  attr_accessor :long_name,:short_name, :types

  def initialize(hash)
      @types=hash[:types]
      @long_name=hash[:long_name]
      @short_name=hash[:short_name]
  end

end
