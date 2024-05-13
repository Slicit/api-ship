class Shipment < ApplicationRecord
  belongs_to :company

  has_many :shipment_products
  has_many :products, through: :shipment_products, foreign_key: :shipment_id

  def self.with_relations
    joins(:products).includes(:products)
  end
end
