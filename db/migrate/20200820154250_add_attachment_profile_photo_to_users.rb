class AddAttachmentProfilePhotoToUsers < ActiveRecord::Migration[6.0]
  def self.up
    add_attachment :users, :profile_photo
  end

  def self.down
    remove_attachment :users, :profile_photo
  end
end
