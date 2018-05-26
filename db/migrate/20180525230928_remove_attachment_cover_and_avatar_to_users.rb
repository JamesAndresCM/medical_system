class RemoveAttachmentCoverAndAvatarToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_attachment :users, :avatar
    remove_attachment :users, :cover
  end
end
