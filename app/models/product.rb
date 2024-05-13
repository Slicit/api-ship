class Product < ApplicationRecord
  belongs_to :company

  has_many :shipment_products
  has_many :shipments, through: :shipment_products

  def quantity(shipment_id = nil)
    objects = shipment_products
    objects = objects.where(shipment_id:) if shipment_id.present?

    objects.sum(:quantity)
  end

  def active_shipment_count
    shipment_products.count
  end
end
