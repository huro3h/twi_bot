class BlogPost
  include ActiveModel::Serializers::JSON

  ATTRIBUTES = %i[subject body created_at]

  attr_accessor *ATTRIBUTES

  def attributes=(hash)
    hash.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def attributes
    {
      subject: @subject,
      body: @body,
      created_at: @created_at
    }
  end
end
