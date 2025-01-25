require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#total_price' do
    let(:params) do
      {
        order_products_attributes: [
          {
            product_id: 1,
            quantity: 3
          },
          {
            product_id: 2,
            quantity: 2
          }
        ]
      }
    end

    subject { Order.new(params).total_price }

    it { is_expected.to be 700 + 70 }

    context '商品がひとつも選択されていない場合' do
      let(:params) do
        {
          order_products_attributes: []
        }
      end

      it { is_expected.to be 0 }
    end

    context '消費税に端数が出た場合' do
      before do
        create(:product, id: 999, price: 299) #factorybotを使ってテストデータを作成する方法
      end

      let(:params) do
        {
          order_products_attributes: [
            {
              product_id: 999,
              quantity: 1
            }
          ]
        }
      end

      # 端数は一律で切り上げ
      it { is_expected.to be 329 }
    end
  end

  describe '#valid?' do
    let(:name) { 'サンプルマン' }
    let(:email) { 'test@example.com' }
    let(:telephone) { '09012345678' }
    let(:delivery_address) { '東京都渋谷区亀有公園前1-2-1' }
    let(:payment_method_id) { 1 }
    let(:other_comment) { "テストコメント" }
    let(:direct_mail_enabled) { true }
    let(:params) do
      {
        name:,
        email:,
        telephone:,
        delivery_address:,
        payment_method_id:,
        other_comment:,
        direct_mail_enabled:
      }
    end

    subject { Order.new(params).valid? }

    it { is_expected.to eq true }

    context '名前が空白の場合' do
      let(:name) { '' }

      it { is_expected.to eq false }
    end

    context 'メールアドレスが空白の場合' do
      let(:email) { '' }

      it { is_expected.to eq false }
    end

    context 'メールアドレスの書式が正しくない場合' do
      let(:email) { 'testexample.com' }

      it { is_expected.to eq false }
    end

    context 'メールアドレスが全角の場合' do
      let(:email) { 'ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ' }

      it { is_expected.to eq true }
    end

    context '電話番号が空白の場合' do
      let(:telephone) { '' }

      it { is_expected.to eq false }
    end

    context '電話番号が全角の場合' do
      let(:telephone) { '０３１２３４５６７８' }

      it { is_expected.to eq true }
    end

    context '電話番号にハイフンが含まれている場合' do
      let(:telephone) { '090-1234-5678' }

      it { is_expected.to eq true }
    end

    context '電話番号の桁が12桁の場合' do
      let(:telephone) { '090123456789' }

      it { is_expected.to eq false }
    end

    context 'お届け先住所が空白の場合' do
      let(:delivery_address) { '' }

      it { is_expected.to eq false }
    end

    context '支払い方法が未入力の場合' do
      let(:payment_method_id) { nil }

      it { is_expected.to eq false }
    end

    context 'その他・ご要望が空白の場合' do
      let(:other_comment) { '' }

      it { is_expected.to eq true }
    end

    context 'その他・ご要望が1000文字の場合' do
      let(:other_comment) { 'あ' * 1_000 }

      it { is_expected.to eq true }
    end

    context 'その他・ご要望が1000文字より多い場合' do
      let(:other_comment) { 'あ' * 1_001 }

      it { is_expected.to eq false }
    end

    context 'メールマガジンの配信が未選択の場合' do
      let(:direct_mail_enabled) { nil }

      it { is_expected.to eq false }
    end
  end
end
