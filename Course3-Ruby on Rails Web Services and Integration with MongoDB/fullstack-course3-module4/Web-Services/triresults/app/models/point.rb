class Point
  attr_accessor :longitude, :latitude

  def initialize (lng,lat)
    @longitude= lng
    @latitude=lat
  end

  def mongoize
    return {"type": "Point", "coordinates": [@longitude,@latitude]}
  end

  def self.demongoize obj
    if obj.is_a? Hash
      @longitude= obj[:coordinates][0]
      @latitude = obj[:coordinates][1]
      return Point.new(@longitude,@latitude)
    elsif obj.is_a? Point
      @longitude = obj.longitude
      @latitude = obj.latitude
      return Point.new(@longitude,@latitude)
    elsif obj.nil?
      return nil
    end
  end

  def self.mongoize obj
    if obj.is_a? Hash
      @longitude= obj[:coordinates][0]
      @latitude = obj[:coordinates][1]
      return (Point.new(@longitude,@latitude)).mongoize
    elsif obj.is_a? Point
      obj.mongoize
    elsif obj.nil?
      return nil
    end

  end

  def self.evolve obj
    if obj.is_a? Hash
      @longitude= obj[:coordinates][0]
      @latitude = obj[:coordinates][1]
      return (Point.new(@longitude,@latitude)).mongoize
    elsif obj.is_a? Point
      obj.mongoize
    elsif obj.nil?
      return nil
    end
  end

end
