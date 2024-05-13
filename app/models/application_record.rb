class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def object_class
    self.class.safe_constantize
  end
end
