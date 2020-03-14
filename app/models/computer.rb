class Computer
  include ActiveModel::Dirty

  define_attribute_methods :name

  # getter
  def name
    @name
  end

  # setter
  def name=(value)
    name_will_change! unless value == @name
    @name = val
  end

  def save
    @previously_changed = changes
    @changed_attributes.clear
  end
end