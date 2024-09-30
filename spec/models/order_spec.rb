require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    let(:name) { 'サンプルマン' }
    let(:email) { 'test@example.com' }
    let(:telephone) { '09012345678' }
    let(:delivery_address) { '東京都渋谷区亀有公園前1-2-1' }
    let(:params) do
      {
        name:,
        email:,
        telephone:,
        delivery_address:
      }
    end

    it '返り値が正しいこと' do
      order = Order.new(params)
      expect(order.valid?).to eq true
    end
  end
end
