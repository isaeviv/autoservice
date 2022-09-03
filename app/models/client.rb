class Client < ApplicationRecord
  validates_presence_of :first_name, :second_name
  has_many  :orders
  has_many  :services
  store_accessor :adress

  before_save :set_full_name_cache

  def set_full_name_cache
    self.full_name_cache = self.decorate.full_name
  end
end
