class ReviewStatusPage < ActiveRecord::Migration[5.2]
  def change
    remove_column :status_pages, :domain_name, :string
    remove_column :status_pages, :subdomain, :string, null: false
    add_column :status_pages, :slug, :string
    add_index :status_pages, :slug, unique: true

    StatusPage.all.each do |s|
      s.slug = s.title.parameterize
      s.save!
    end

    change_column_null(:status_pages, :slug, false)
  end
end
