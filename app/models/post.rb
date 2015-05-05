class Post < ActiveRecord::Base

  class UrlValidator < ActiveModel::Validator
    def validate(record)
      begin
        uri = URI.parse(record.link)
        valid_url = uri.kind_of?(URI::HTTP)
      rescue URI::InvalidURIError
        valid_url = false
      end

      unless valid_url
        record.errors[:url] << "Please enter a valid URL."
      end
    end
  end

end


class Post
  belongs_to :user
  has_many :votes, as: :votable
  has_many :comments

  validates :title,
    presence: true,
    length: {minimum:5, maximum:200}


  validates :link,
    presence: true

  validates_with UrlValidator

end




