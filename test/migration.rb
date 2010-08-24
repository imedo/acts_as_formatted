PluginTestEnvironment::Migration.setup do 
  add_column :articles, :text, :text
  add_column :articles, :formatted_text, :text
  add_column :articles, :summary, :text
  add_column :articles, :formatted_summary, :text
  
  add_column :articles, :updated_at, :datetime
  add_column :articles, :created_at, :datetime
end
