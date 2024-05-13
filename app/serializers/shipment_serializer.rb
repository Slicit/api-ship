class ShipmentSerializer < ActiveModel::Serializer
  attribute(:id)
  attribute(:name)
  attribute(:company_id)
  attribute(:international_transportation_mode)
  attribute(:international_departure_date)
  attribute(:created_at)
  attribute(:updated_at)

  has_many :products do
    object.products.map do |product|
      ProductSerializer.new(product, scope: { shipment_id: object.id }).as_json
    end
  end
end
