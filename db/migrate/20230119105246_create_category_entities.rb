class CreateCategoryEntities < ActiveRecord::Migration[7.0]
  def change
    create_table :category_entities do |t|
      t.bigint :entity_id, null: false
      t.bigint :category_id, null: false
      t.index [:entity_id], name: :index_category_entities_on_entity_id
      t.index [:category_id], name: :index_category_entities_on_category_id
      t.timestamps
    end
  end
end
