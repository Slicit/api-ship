class ApplicationController < ActionController::Base
  def object_key
    object_class.to_s.underscore.singularize
  end

  def objects_key
    object_key.pluralize
  end
end
