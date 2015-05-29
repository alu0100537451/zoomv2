class CreateRelationlikes < ActiveRecord::Migration
  def change
    create_table :relationlikes do |t|
      t.string :post_id
      t.string :liker_id

      t.timestamps null: false
    end
  end
end
