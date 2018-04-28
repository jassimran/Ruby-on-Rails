class Point
  attr_accessor :longitude, :latitude

  def initialize (lng,lat)
    @longitude= lng
    @latitude=lat
  end

  def mongoize
    return {"type": "Point", "coordinates": [@longitude,@latitude]}
  end

  def self.demongoize hash
    @longitude= hash[:coordinates][0]
    @latitude = hash[:coordinates][1]
    return Point.new(@longitude,@latitude)
  end

  def self.mongoize obj
    if obj.instance_of? Hash
        @longitude= obj[:coordinates][0]
        @latitude = obj[:coordinates][1]
    elsif obj.instance_of? Point
      @longitude = obj.longitude
      @latitude = obj.latitude
    end
    return (Point.new(@longitude,@latitude)).mongoize
  end

  def self.evolve obj
    if obj.instance_of? Hash
        @longitude= obj[:coordinates][0]
        @latitude = obj[:coordinates][1]
    elsif obj.instance_of? Point
      @longitude = obj.longitude
      @latitude = obj.latitude
    end
    return (Point.new(@longitude,@latitude)).mongoize
  end

end
