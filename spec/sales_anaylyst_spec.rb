require_relative 'sales_analyst'

RSpec.describe 'SalesAnalyst' do
  describe '#initialize' do
    it 'creates an instance of SalesAnalyst' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa).to be_an_instance_of(SalesAnalyst)
    end
    it 'is passed its engine' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.engine).to be_an_instance_of(SalesEngine)
    end
  end
  describe '#average_items_per_merchant' do
    it 'returns the average number of items all merchants sell' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.average_items_per_merchant).to eq(2.88)
    end
  end
  describe '#average_items_per_merchant_standard_deviation' do
    it 'returns the standard deviation of items per merchant' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.average_items_per_merchant_standard_deviation).to eq(3.26)
    end
  end
  describe '#merchants_with_high_item_count' do
    it 'returns all merchants more than one standard deviation on number of items' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.merchants_with_high_item_count[0].id).to eq('12334123')
    end
  end
  describe '#average_item_price_for_merchant' do
    it 'returns the average prices for the merchant identified by their id' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.average_item_price_for_merchant('12334159')).to eq(3_150.00)
    end
  end
  describe '#average_average_price_per_merchant' do
    it 'returns the average of all average prices' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.average_average_price_per_merchant).to eq(35_029.47)
    end
  end
  describe '#average_item_price' do
    it 'returns the average of the price of all items' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.average_item_price).to eq(25_105.51)
    end
  end
  describe '#item_price_standard_deviation' do
    it 'is evil witch magic' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.item_price_standard_deviation).to eq(290_099.00)
    end
  end
  describe '#golden_items' do
    it 'returns an array of all items more than 2 standard deviations from average' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      sa = se.analyst

      expect(sa.golden_items.length).to eq(5)
    end
  end
end
