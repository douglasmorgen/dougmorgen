class CreateInquiries < ActiveRecord::Migration[8.1]
  def change
    create_table :inquiries do |t|
      t.string :name
      t.string :email
      t.string :company
      t.string :phone
      t.string :project_type
      t.string :budget
      t.string :timeline
      t.text :message
      t.string :source_page
      t.string :status, null: false, default: "new"
      t.string :honeypot

      t.timestamps
    end

    add_index :inquiries, :created_at
    add_index :inquiries, :email
    add_index :inquiries, :status
  end
end
