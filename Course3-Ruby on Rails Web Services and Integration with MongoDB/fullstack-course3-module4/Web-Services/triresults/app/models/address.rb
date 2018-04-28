class Address
  attr_accessor :city, :state, :location

  def initialize (city=nil,st=nil,loc=nil)
    @city= city
    @state=st
    if !loc.nil?
      @location=Point.new(loc[:coordinates][0], loc[:coordinates][1])
    else
      @location = Point.new(0.0, 0.0)
    end
  end

  def mongoize
    return {:city => @city, :state => @state, "loc": {"type": "Point", "coordinates": [@location.longitude, @location.latitude]}}
  end

  def self.demongoize obj
    if obj.is_a? Hash
      @city = obj[:city]
      @state = obj[:state]
      @location = obj[:loc]
      return Address.new(@city, @state, @location)
    elsif obj.is_a? Address
      return obj
    elsif obj.nil?
      return nil
    end
  end

  def self.mongoize obj
    if obj.is_a? Hash
      @city = obj[:city]
      @state = obj[:state]
      @location = obj[:loc]
      return Address.new(@city, @state, @location).mongoize
    elsif obj.is_a? Address
      return obj.mongoize
    elsif obj.nil?
      return nil
    end
  end

  def self.evolve obj
    if obj.is_a? Hash
      @city = obj[:city]
      @state = obj[:state]
      @location = obj[:loc]
      return Address.new(@city, @state, @location).mongoize
    elsif obj.is_a? Address
      return obj.mongoize
    elsif obj.nil?
      return nil
    end
  end

end
