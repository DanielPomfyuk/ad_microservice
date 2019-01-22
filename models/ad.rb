class Ad < ActiveRecord::Base
  validates :real_estate_type,:rooms,:square,:address, presence: true
  enum real_estate_type: [ :house, :flat, :apartment, :residance ]
end