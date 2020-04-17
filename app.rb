require_relative 'lib/config'
require_relative 'lib/param'
require_relative 'lib/billing'
require_relative 'lib/billing_store'
require_relative 'lib/render'

# The main App
file_name = 'data/billings.yml'
billing_store = BillingStore.new(file_name)
console_render = Render.new

# Load from file by entry (OR the last)
billing_loaded = billing_store.load
console_render.render(billing_loaded)
console_render.render_to_pay(billing_loaded)

billing = Billing.new(@values)
billing.create_params(billing_loaded)
billing.calculate

console_render.render(billing)

# Ask: how much to pay this month
to_pay = console_render.ask_to_pay(billing)

billing.calculate_next_modifier(to_pay)

console_render.render_to_pay(billing)

# Ask to Save to a File
if console_render.ask_to_save_file
  billing_store.save(billing)
  console_render.render_saved_file(billing_store.original_file_name)
end
