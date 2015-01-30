class AddAttachmentPhotoToIssues < ActiveRecord::Migration
  def self.up
    change_table :issues do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :issues, :photo
  end
end
