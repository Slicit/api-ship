class ProductSerializer < ActiveModel::Serializer
  attribute(:id)
  attribute(:sku)
  attribute(:quantity) { object.quantity(scope[:shipment_id]) }
  attribute(:active_shipment_count)
  attribute(:description)
  attribute(:created_at)
  attribute(:updated_at)
end
