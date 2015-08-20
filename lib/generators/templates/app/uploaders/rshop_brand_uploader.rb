# encoding: utf-8

class RshopBrandUploader < RshopBaseImageUploader
  version :list do
    process :resize_to_limit => [345, 345]
  end
end
