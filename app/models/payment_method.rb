class PaymentMethod < ApplicationRecord
  class << self
    def selectable_methods
      # allメソッドは、PaymentMethodの全てのレコードを取得するメソッド。それをmapメソッドで、nameとidの配列に変換している。この場合、valueとしてidをが返される。
      all.map { |method| [method.name, method.id] }
    end
  end
end
