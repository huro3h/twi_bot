# frozen_string_literal: true
# sandbox_code

class Person
  include ActiveModel::AttributeMethods

  attr_accessor :name, :age, :address

  # 属性名にprefixとsuffixの両方をつけたメソッドを同時に定義
  attribute_method_affix prefix: 'reset_', suffix: '_to_default_zero_by!'

  # 属性名にprefixのみ
  attribute_method_prefix 'clear_'

  # 属性名にsuffixのみ
  attribute_method_suffix '_to_ok!'

  # 注意！
  # define_attribute_methods は attribute_method_**
  # より後に宣言する必要がある！
  define_attribute_methods :name, :age, :address

  # 初期化時に属性を定義する必要があるが、initializeでもattributesでも
  # どっちでもいける

  # def initialize
  #   @name = name
  #   @age = age
  #   @address = address
  # end

  def attributes
    {
      name: @name,
      age: @age,
      address: @address
    }
  end

  private

  def clear_attribute(attribute)
    send("#{attribute}=", nil)
  end

  def attribute_to_ok!(attribute)
    send("#{attribute}=", 'ok')
  end

  def reset_attribute_to_default_zero_by!(attribute)
    send("#{attribute}=", 0)
  end
end
