class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :url, null: false
      t.string :name, null: false
      t.references :category
      t.string :photo_url, default: "http://designmodo.github.io/Flat-UI/img/icons/svg/book.svg"
      t.references :platform

      t.timestamps null: false
    end
  end
end
