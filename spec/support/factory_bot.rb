# testコード中でFactory_botのメソッド使用の際、
# 名前空間の指定を省略可能に

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end