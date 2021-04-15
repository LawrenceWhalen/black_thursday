require 'csv'
require_relative 'repository'
require_relative 'item'
require 'time'

# Basic ItemRepository class
class ItemRepository < Repository

  def initialize(location_hash, engine)
    super(location_hash, engine)
    all_items
  end

  def all_items
    @csv_array = []
    CSV.parse(File.read(@location_hash[:items]), headers: true).each do |item|
      @csv_array << Item.new(id: item[0],
                             name: item[1],
                             description: item[2],
                             cent_price: item[3],
                             created_at: Time.parse(item[5]),
                             updated_at: Time.parse(item[6]),
                             merchant_id: item[4],
                             repository: self)
    end
  end

  def find_all_with_description(string)
    @csv_array.find_all do |item|
      item.description.downcase.include?(string.downcase)
    end
  end

  def find_all_by_price(amount)
    @csv_array.find_all do |item|
      item.unit_price == amount
    end
  end

  def find_all_by_price_in_range(range)
    @csv_array.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @csv_array.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(item_hash)
    attributes = {
      id: max_id_number_new,
      name: item_hash[:name],
      description: item_hash[:description],
      cent_price: item_hash[:unit_price]*100,
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: item_hash[:merchant_id].to_i,
      repository: self
    }
    @csv_array << Item.new(attributes)
    Item.new(attributes)
  end

  def update(id, attributes)
    update_instance = find_by_id(id)
    if update_instance.nil?
      nil
    elsif !attributes[:name].nil?
      update_instance.name = attributes[:name]
      update_instance.updated_at = Time.now
    elsif !attributes[:description].nil?
      update_instance.description = attributes[:description]
      update_instance.updated_at = Time.now
    elsif !attributes[:unit_price].nil?
      update_instance.cent_price = BigDecimal(attributes[:unit_price] * 100, 10)
      update_instance.updated_at = Time.now
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
