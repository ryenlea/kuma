class PhotoUploader < CarrierWave::Uploader::Base
  #include CarrierWave::MiniMagick
  storage :file
  include Sprockets::Helpers

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    image_path('sharePic.png')
  end

  version :thumb do
    process :resize_to_fill => [230,230]
  end
end
