require_relative 'lib/config'
require_relative 'lib/param'
require_relative 'lib/billing'
require_relative 'lib/billing_store'
require_relative 'lib/render'

# The main App
file_name = 'data/billings.yml'
billing_store = BillingStore.new(file_name)
console_render = Render.new

# Load current values
values_file_name = 'data/values.yml'
values_store = BillingStore.new(values_file_name)
current_values = values_store.load

billings = Billing.load_all(billing_store)
billing_previous = Billing.previous

console_render.render(billing_previous)
console_render.render_to_pay(billing_previous)

billing = Billing.new(current_values)
Billing.calculate_current

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
