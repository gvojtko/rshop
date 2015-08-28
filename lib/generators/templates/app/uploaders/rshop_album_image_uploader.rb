# encoding: utf-8

class ::RshopAlbumImageUploader < RshopBaseImageUploader
  version :list do
    process :resize_to_fill => [345, 345]
    process :watermark_bottom
  end
  version :show do
    process :resize_to_limit => [345, 700]
    process :watermark_bottom
  end
  version :gallery do
    process :resize_to_fill => [78, 78]
  end

  version :origin do
    process :resize_to_limit => [2000, 1000]
    process :watermark_bottom
  end

  def watermark_text
    # pr = model.album ? model.album.albumizable : nil
    # pr.respond_to?(:name2) ? "#{pr.name}\nwww.korma.in.ua " : 'www.korma.in.ua'
  end

  def watermark_center
  end

  def watermark_bottom
    return unless watermark_text
    manipulate! do |img|
      # logo = Magick::Image.read("#{Rails.root}/app/assets/images/logo.png").first
      # img = img.composite(logo, Magick::SouthEastGravity, Magick::OverCompositeOp)

      mark = Magick::Image.new(img.rows, img.columns) {self.background_color = "none"}

      draw = Magick::Draw.new
      draw.font = 'Helvetica'
      draw.pointsize = 32
      draw.font_weight = Magick::BoldWeight
      draw.fill = '#CCCCCC'
      draw.gravity = Magick::SouthGravity
      draw.annotate(mark, 0, 0, 0, 15, self.watermark_text)

      img = img.dissolve(mark, 0.15, 0.2, Magick::CenterGravity)
      img
    end
  end
end
