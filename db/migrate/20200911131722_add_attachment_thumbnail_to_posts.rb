class AddAttachmentThumbnailToPosts < ActiveRecord::Migration[6.0]
  def self.up
    change_table :posts do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    remove_attachment :posts, :thumbnail
  end
end
