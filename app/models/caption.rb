class Caption < ActiveRecord::Base
  belongs_to :gend_image

  attr_accessible :font, :height_pct, :text, :top_left_x_pct, :top_left_y_pct, :width_pct

  validates :text, presence: true

  before_save :default_values

  def default_values
    if font.blank?
      self.font = MemeCaptainWeb::Config::DefaultFont
    end
  end

  def font_path
    "#{Rails.root}/fonts/#{font}"
  end

  def text_pos
    MemeCaptain::TextPos.new(text, top_left_x_pct, top_left_y_pct, width_pct, height_pct, :font => font_path)
  end

end
