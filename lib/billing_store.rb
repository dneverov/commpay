require 'yaml/store'

class BillingStore
  attr_reader :original_file_name, :store
  # To hard save with defined entity_id. E.g. 'march_2020'. Set =nil to disable
  BindedId = nil

  def initialize(file_name)
    @store = YAML::Store.new(file_name)
    @original_file_name = file_name
  end

  def save(billing)
    # Set entity_id
    entity_id = BindedId || billing.created_at.strftime("%B_%Y").downcase

    @store.transaction do
      @store[entity_id] = billing
    end
    puts "Saved file: '#{original_file_name}'"
  end
end