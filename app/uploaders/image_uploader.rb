class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :tags => ["gallery"]
  process :convert => "jpg"

  version :thumbnail do
    eager
    resize_to_fit(300, 200)
    cloudinary_transformation :quality => 80
  end
end
