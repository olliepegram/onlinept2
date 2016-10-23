class AddFileToListing < ActiveRecord::Migration[5.0]
  def change
    add_attachment :listings, :file  
  end
end
