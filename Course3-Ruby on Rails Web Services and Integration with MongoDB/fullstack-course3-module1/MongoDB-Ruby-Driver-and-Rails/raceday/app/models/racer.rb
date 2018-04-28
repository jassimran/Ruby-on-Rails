class Racer
  include ActiveModel::Model

  attr_accessor :id, :number, :first_name, :last_name, :gender, :group, :secs

  def initialize(params={})
    @id=params[:_id].nil? ? params[:id] : params[:_id].to_s
    @number=params[:number].to_i
    @first_name=params[:first_name]
    @last_name=params[:last_name]
    @gender=params[:gender]
    @group=params[:group]
    @secs=params[:secs].to_i
  end

  def self.mongo_client
    Mongoid::Clients.default
  end

  def self.collection
    self.mongo_client['racers']
  end

  def self.all(prototype={},sort={:number => 1},skip=0,limit=nil)
    result = collection.find(prototype).sort(sort).skip(skip)
    return limit.nil? ? result : result.limit(limit)
  end

  def self.find id
    result = collection.find(:_id => BSON::ObjectId.from_string(id)).first
    return result.nil? ? nil : Racer.new(result)
  end

  def persisted?
    !@id.nil?
  end

  def created_at
    nil
  end

  def updated_at
    nil
  end

  def save
    result=self.class.collection.insert_one(:number => @number, :first_name => @first_name, :last_name => @last_name, :gender => @gender, :group => @group, :secs => @secs)
    @id=result.inserted_id.to_s #store just the string form of the _id
  end

  def update(params)
    @number=params[:number].to_i
    @first_name=params[:first_name]
    @last_name=params[:last_name]
    @group=params[:group]
    @gender=params[:gender]
    @secs=params[:secs].to_i
    params.slice!(:number, :first_name, :last_name, :gender, :group, :secs)
    self.class.collection.find(:_id => BSON::ObjectId.from_string(@id)).update_one(params)
  end

  def destroy
    self.class.collection.find(:number => @number).delete_one()
  end

  def self.paginate(params)
    page=(params[:page] || 1).to_i
    limit=(params[:per_page] || 30).to_i
    skip=(page-1)*limit
    racers=[]
    all({},sort={:number => 1},skip,limit).each do |doc|
      racers << Racer.new(doc)
    end
    
    total=all({},sort={:number => 1},skip,limit).count

    WillPaginate::Collection.create(page, limit, total) do |pager|
      pager.replace(racers)
    end
  end

end
