class AddAttachmentThumbnailToEvents < ActiveRecord::Migration[6.0]
  def self.up
    add_attachment :events, :thumbnail
  end

  def self.down
    remove_attachment :events, :thumbnail
  end
end
