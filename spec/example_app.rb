class Account < ActiveRecord::Base
  has_many :users
  has_one :account_history
end

class AccountHistory < ActiveRecord::Base
  belongs_to :account
end

class Supplier < ActiveRecord::Base
  has_one :account_history, through: :account
end

class User < ActiveRecord::Base
  belongs_to :account
end

class Employee < ActiveRecord::Base
  has_many :subordinates, class_name: "Employee", foreign_key: "manager_id"
  belongs_to :manager, class_name: "Employee"

  has_many :pictures, :as => :imageable
end

#class Product < ActiveRecord::Base
  #has_many :pictures, :as => :imageable
#end

class Picture < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => :true
end

class Assembly < ActiveRecord::Base
  has_and_belongs_to_many :parts
end

class Part < ActiveRecord::Base
  has_and_belongs_to_many :assemblies
end

class Physician < ActiveRecord::Base
  has_many :appointments
  has_many :patients, :through => :appointments
end

class Appointment < ActiveRecord::Base
  belongs_to :physician
  belongs_to :patient
end

class Patient < ActiveRecord::Base
  has_many :appointments
  has_many :physicians, :through => :appointments
end

class Order < ActiveRecord::Base
  belongs_to :customer, class_name: "User", foreign_key: "user_id"
end
