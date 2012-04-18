
def initialize(*args)
  super
  @action = :create
end

actions :create, :delete

attribute :fields, :kind_of => Hash, :required => true

%w(dashboard_name dashboard_category).each do |attr_string_req|
  attribute attr_string_req, :kind_of => String, :required => true
end

string_attrs = %w(vtitle description major_grid_line_color minor_grid_line_color from until)
string_attrs.each do |attr_string|
  attribute attr_string, :kind_of => String, :required => false
end

int_attrs = %w(width height ymin ymax linewidth fontsize)
int_attrs.each do |attr_int|
  attribute attr_int, :kind_of => Fixnum, :required => false
end

bool_attrs = %w(hide_legend draw_null_as_zero fontbold hide_grid)
bool_attrs.each do |attr_bool|
  attribute attr_bool, :kind_of => [TrueClass, FalseClass], :required => false
end

attribute :area, :equal_to => [:all, :first, :none, :stacked], :required => false
attribute :linemode, :equal_to => %w(slope staircase), :required => false

::GDASH_RESOURCE_ATTRIBS = string_attrs + int_attrs + bool_attrs + %w(area linemode)

