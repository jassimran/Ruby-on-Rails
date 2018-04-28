require 'exifr/jpeg'
class Photo

  attr_accessor :id, :location
  attr_writer :contents

  def initialize hash=nil
    if !hash.nil?
      @id=hash[:_id].to_s
      @location=Point.new(hash[:metadata][:location])
      @place = hash[:metadata][:place]
    end
  end

  def place
    if !@place.nil?
      Place.find(@place.to_s)
    end
  end

  def place= (input)
    if input.is_a? String
      @place = BSON::ObjectId.from_string(input)
    else
      @place=input
    end
  end

  def self.mongo_client
    Mongoid::Clients.default
  end

  def persisted?
    !@id.nil?
  end

  def save
    if @place.is_a? Place
          @place = BSON::ObjectId.from_string(@place.id)
        end
    if !persisted?
      gps=EXIFR::JPEG.new(@contents).gps
      @location= Point.new(:lng=>gps.longitude, :lat=>gps.latitude)
      @contents.rewind

      desc ={}
      desc[:metadata] = {:location => @location.to_hash, :place => @place}
      desc[:content_type] = "image/jpeg"
      grid_file = Mongo::Grid::File.new(@contents.read, desc)
      @id =self.class.mongo_client.database.fs.insert_one(grid_file).to_s
    else
      grid_file=self.class.mongo_client.database.fs.find(:_id=>BSON::ObjectId.from_string(@id)).first
      grid_file[:metadata] = {:location => @location.to_hash, :place => @place}
      self.class.mongo_client.database.fs.find(:_id=>BSON::ObjectId.from_string(@id)).update_one(grid_file)


    end
  end

  def self.all offset=0, limit=nil
    if !limit.nil?
      mongo_client.database.fs.find.skip(offset).limit(limit).map{|doc| Photo.new(doc)}
    else
      mongo_client.database.fs.find.skip(offset).map{|doc| Photo.new(doc)}
    end
  end

  def self.find input_id
    grid_file=mongo_client.database.fs.find(:_id=> BSON::ObjectId.from_string(input_id)).first
    if grid_file.nil?
      return nil
    else
      Photo.new(grid_file)
    end
  end

  def contents
    data_bytes=""
    grid_file=self.class.mongo_client.database.fs.find_one(:_id=> BSON::ObjectId.from_string(@id))
    grid_file.chunks.reduce([]) { |x,chunk| data_bytes << chunk.data.data }
    return data_bytes
  end

  def destroy
      self.class.mongo_client.database.fs.find(:_id=> BSON::ObjectId.from_string(@id)).delete_one
  end

  def find_nearest_place_id max_dist
    Place.near(@location.to_hash, max_dist).limit(1).projection({:_id=>1}).first[:_id]
  end

  def self.find_photos_for_place bsonId_place
    if bsonId_place.is_a? String
      mongo_client.database.fs.find('metadata.place' => BSON::ObjectId.from_string(bsonId_place))
    else
      mongo_client.database.fs.find('metadata.place' => bsonId_place)
    end
  end
end
