class AddedDomainDifferentiation < ActiveRecord::Migration
  def change
    add_column :sites, :domain, :string
  end
end
