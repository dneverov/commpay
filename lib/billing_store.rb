require 'yaml/store'

class BillingStore
  attr_reader :original_file_name, :store

  def initialize(file_name)
    @store = YAML::Store.new(file_name)
    @original_file_name = file_name
  end

  def save(billing)
    # Set entity_id
    entity_id = BindedId || billing.created_at.strftime("%B_%Y").downcase

    store.transaction do
      store[entity_id] = billing
    end
    puts "Saved file: '#{original_file_name}'"
  end

  def load(entity_id = nil)
    # Load from file by entry
    entity_root = store.transaction do |bs|
      #  Default entity_id
      entity_id = bs.roots.last unless entity_id
      bs[entity_id]
    end
  end
end
