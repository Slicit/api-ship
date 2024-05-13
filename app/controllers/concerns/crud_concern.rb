module CrudConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_object, only: %i[show update destroy]
  end

  def index
    render json: { "#{objects_key}": list(object_class, params) }
  rescue StandardError => e
    render json: { errors: [e.message] }, status: :unprocessable_entity
  end

  def show
    render json: @object
  end

  def create
    render json: { errors: ['method not allowed'] }, status: :method_not_allowed

    # object = object_class.new(object_params)
    # if object.save
    #   render json: serialize(object), status: :created
    # else
    #   render json: object.errors, status: :unprocessable_entity
    # end
  end

  def update
    render json: { errors: ['method not allowed'] }, status: :method_not_allowed

    # if @object.update(object_params)
    #   render json: serialize(@object)
    # else
    #   render json: @object.errors, status: :unprocessable_entity
    # end
  end

  def destroy
    render json: { errors: ['method not allowed'] }, status: :method_not_allowed

    # @object.destroy
    # head :no_content
  end

  private

  def object_params
    params.require(object_key).permit! # permit all for the TEST purpose, we must filter to prevent unwanted params here
  end

  def list(object_class, params)
    object_class = filter(object_class, params)
    object_class = sort(object_class, params)
    object_class = paginate(object_class, params)

    serialize(object_class)
  end

  def filter(object_class, _params)
    object_class.all
  end

  def sort(object_class, params)
    direction = params[:direction] == 'desc' ? 'desc' : 'asc'
    if params[:sort].present?
      object_class.order(params[:sort] => direction)
    else
      object_class.order(id: :asc)
    end
  end

  def paginate(object_class, params)
    per_page = (params[:per] || 4).to_i
    page = (params[:page] || 1).to_i

    object_class.limit(per_page).offset((page - 1) * per_page)
  end

  def serialize(objects)
    ActiveModelSerializers::SerializableResource.new(objects, list_format: true)
  end

  # On show/update/destroy actions, we want to ensure the object exists, or return a 404
  def set_object
    @object = object_class.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["#{object_key} not found"] }, status: :not_found
  end
end
