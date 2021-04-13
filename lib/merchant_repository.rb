require './lib/merchant'

class MerchantRepository

  def initialize(csv_array)
    @csv_array = csv_array
  end

  def all
    @csv_array
  end

  def find_by_id(id)
    @csv_array.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @csv_array.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @csv_array.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def max_id_plus_one
      max = @csv_array.max_by do |merchant|
      merchant.id
      end
      new = max.id.to_i + 1
      new.to_s
  end

  def create(name)
    @csv_array << Merchant.new( {id: max_id_plus_one,
                  name: name})
  end

  def update(id, name)
    new = @csv_array.find do |merchant|
      merchant.id == id
    end

    new.name = name
  end

  def delete(id)
    remove = @csv_array.find do |merchant|
      merchant.id == id
    end

    @csv_array.delete(remove)
  end
end
