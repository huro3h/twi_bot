class Computer
  include ActiveModel::Dirty

  # 変更を検知したい属性名を指定
  define_attribute_methods :name

  # getter
  def name
    @name
  end

  # setter
  def name=(value)
    # xxx_will_change! 特定のカラムの変更状態を追跡
    name_will_change! unless value == @name
    @name = value
  end

  def save
    # 前回の変更箇所と値を @previously_changed に保持
    @previously_changed = changes

    # 状態のクリア
    @changed_attributes.clear
  end
end