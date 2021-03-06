class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Sprockets::Helpers
  storage :file
  
  process :resize_to_fit => [80, 80]
  process :convert => 'png' 
  
  def filename 
      "logo.#{model.avatar.file.extension}" if original_filename
  end 
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
   image_path('face.png')
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
