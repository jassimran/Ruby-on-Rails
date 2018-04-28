class Placing
  attr_accessor :name, :place

  def initialize (name,place)
    @name= name
    @place=place
  end

  def mongoize
    {:name => @name, :place => @place}
  end

  def self.demongoize obj
    if obj.is_a? Hash
      @name= obj[:name]
      @place = obj[:place]
      return Placing.new(@name,@place)
    elsif obj.is_a? Placing
      return obj
    elsif obj.nil?
      return nil
    end
  end

  def self.mongoize(obj)
    if obj.is_a? Hash
      @name= obj[:name]
      @place = obj[:place]
      return Placing.new(@name,@place).mongoize
    elsif obj.is_a? Placing
      return obj.mongoize
    elsif obj.nil?
      return nil
    end
  end

  def self.evolve(obj)
    if obj.is_a? Hash
      @name= obj[:name]
      @place = obj[:place]
      return Placing.new(@name,@place).mongoize
    elsif obj.is_a? Placing
      return obj.mongoize
    elsif obj.nil?
      return nil
    end
  end

end
