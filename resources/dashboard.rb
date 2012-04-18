def initialize(*args)
  super
  @action = :create
end

actions :create, :delete

attribute :category, :kind_of => String, :required => true
attribute :description, :kind_of => String, :required => true
