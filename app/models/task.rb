class Task < ActiveRecord::Base
  attr_accessible :name, :status
  belongs_to :user
end
