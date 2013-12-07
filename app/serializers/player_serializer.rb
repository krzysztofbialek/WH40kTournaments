class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :value 


  def value
    object.full_name_with_id
  end
end
