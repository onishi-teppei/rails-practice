class OrderMailerJob < ActiveJob::Base
  queue_as :default

  def perform(order_id)
    sleep 30
    OrderMailer.mail_to_user(order_id).deliver
  end
end
