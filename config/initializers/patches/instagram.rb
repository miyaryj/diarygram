# Moved from app/models because the module name conflicts with instagram gem.
module Instagram
  def self.table_name_prefix
    'instagram_'
  end
end
