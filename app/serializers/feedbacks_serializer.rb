class FeedbacksSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :rating

  def rating
    object.rating.to_i
  end
end
