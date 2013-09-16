class Photo < ActiveRecord::Base
  mount_uploader :path, PhotoUploader

  belongs_to :product
  #attr_accessor :type, :filename, :name, :tempfile , :name, :head
  #attr_accessible :image
  def to_jq_upload
    #binding.pry
    {
      "name" => read_attribute(:path),
      "size" => path.size,
      "url" => path.url,
      #"thumbnail_url" => path.thumb.url,
      "delete_url" => "/photos/#{self.id}",
      "delete_type" => "DELETE" 
    }
  end
end