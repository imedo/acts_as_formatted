PluginTestEnvironment::Migration.setup do 
  add_column :articles, :text, :text
  add_column :articles, :formatted_text, :text
  add_column :articles, :summary, :text
  add_column :articles, :formatted_summary, :text
end
