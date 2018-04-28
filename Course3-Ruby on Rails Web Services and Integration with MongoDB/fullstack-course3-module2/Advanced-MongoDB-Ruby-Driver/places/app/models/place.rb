class Place
  include ActiveModel::Model

  attr_accessor :id, :formatted_address, :location, :address_components

  def initialize hash
    @id=hash[:_id].to_s
    @formatted_address=hash[:formatted_address]
    @location = Point.new(hash[:geometry][:geolocation])
    @address_components=[]
    if !hash[:address_components].nil?
      address_components = hash[:address_components]
      address_components.each { |a| @address_components << AddressComponent.new(a) }
    end
  end

  def persisted?
    !@id.nil?
  end

  def self.mongo_client
    Mongoid::Clients.default
  end

  def self.collection
    self.mongo_client[:places]
  end

  def self.load_all file_handle
    hash=JSON.parse(file_handle.read)
    collection.insert_many(hash)
  end

  def self.find_by_short_name input_short_name
    collection.find({"address_components.short_name" => input_short_name})
  end

  def self.to_places input_view
    places_coll=[]
    input_view.each{ |a| places_coll << Place.new(a) }
    return places_coll
  end

  def self.find input_id
    p=collection.find({:_id => BSON::ObjectId.from_string(input_id)}).first
    if !p.nil?
      Place.new(p)
    else
      nil
    end
  end

  def self.all offset=0, limit=nil
    if limit.nil?
      result = collection.find.skip(offset)
    else
      result = collection.find.skip(offset).limit(limit)
    end

    result.map{|place| Place.new(place)}
  end

  def destroy
    self.class.collection.find(:_id => BSON::ObjectId.from_string(@id)).delete_one
  end

  def self.get_address_components sort=nil,offset=0,limit=nil
    if sort.nil? and limit.nil?
      collection.find.aggregate([
          {:$unwind => '$address_components'},
          {:$project => {:_id=>1, :address_components=>1, :formatted_address=>1, :geometry=>{:geolocation => 1}}},
          {:$skip => offset}])
    elsif sort.nil? and !limit.nil?
      collection.find.aggregate([
          {:$unwind => '$address_components'},
          {:$project=>{:_id => 1,
          :address_components =>1, :formatted_address =>1,
          :geometry =>{:geolocation => 1}}},
          {:$limit => limit},{:$skip => offset}])
    elsif !sort.nil? and limit.nil?
      collection.find.aggregate([
          {:$unwind => '$address_components'},
          {:$project=>{:_id => 1,
          :address_components =>1, :formatted_address =>1,
          :geometry =>{:geolocation => 1}}},
          {:$sort => sort},
          {:$skip => offset}])
    else
      collection.find.aggregate([
      {:$project=>{ :_id=>1, :address_components=>1, :formatted_address=>1, :geometry => {:geolocation => 1}}},
      {:$unwind => '$address_components'},
      {:$sort => sort},
      {:$skip => offset},
      {:$limit => limit}
    ])
    end
  end

  def self.get_country_names
    collection.find.aggregate([
      {:$unwind=>'$address_components'},
      {:$project=>{ :address_components =>{:long_name=>1, :types=>1}}},
      {:$match=>{'address_components.types'=>'country'}},
      {:$group=>{:_id=>'$address_components.long_name',:uniqueCount=>{:$addToSet=>'$_id'}}}
      ]).to_a.map {|h| h[:_id]}
  end

  def self.find_ids_by_country_code country_code
    collection.find.aggregate([
      {:$match=>{'address_components.types'=>'country','address_components.short_name' => country_code}},
      {:$project=>{:_id=>1}}
      ]).map {|doc| doc[:_id].to_s}
  end

  #Geolocation
  def self.create_indexes
    collection.indexes.create_one({'geometry.geolocation'=>Mongo::Index::GEO2DSPHERE})
  end

  def self.remove_indexes
    ind_name = collection.indexes.map {|r| r[:name] }
    collection.indexes.drop_one(ind_name[1])
  end

  def self.near pt, max_meters=nil
    if !max_meters.nil?
      max_meters = max_meters.to_i
      collection.find('geometry.geolocation' =>{'$near'=>pt.to_hash, :$maxDistance=>max_meters})
    else
      collection.find('geometry.geolocation' =>{'$near'=>pt.to_hash})
    end
  end

  def near max_meters=nil
    return self.class.to_places(self.class.near(@location.to_hash, max_meters))
  end

  def photos offset=0, limit=nil
    if !limit.nil?
      Photo.find_photos_for_place(@id).skip(offset).limit(limit).map{|photo| Photo.new(photo)}
    else
      Photo.find_photos_for_place(@id).skip(offset).map{|photo| Photo.new(photo)}
    end
  end

end
