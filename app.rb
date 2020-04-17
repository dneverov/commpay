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
puts

billing = Billing.new(@values)
billing.create_params(billing_loaded)
billing.calculate

# Render
console_render.render(billing)

# Ask: how much to pay
to_pay = console_render.ask_to_pay(billing)

billing.calculate_next_modifier(to_pay)

console_render.render_to_pay(billing)

# Ask to Save to a File
# TODO: Use something like: `if console_render.ask_to_save_file...`
print "\nSave to file? (y/N): "
save_file = gets.chomp

if ['y', 'yes'].include?(save_file.downcase)
  # Save the file
  billing_store.save(billing)
  console_render.render_saved_file(billing_store.original_file_name)
end

#   January 2020
# water_cold: 202.39999999999998
# water_hot: 594.5699999999999
# energy: 574.35
# gas: 56.69
# phone: 0
# ----------
# Subotal: 1428.01
# Total:   1389.01

#  February 2020
# water_cold: 202.40
# water_hot: 594.57
# energy: 563.41
# gas: 56.69
# phone: 0.00
# ----------
# Subotal: 1417.07
# Total:   1406.07

#  March 2020
# water_cold: 242.88
# water_hot: 594.57
# energy: 497.77
# gas: 56.69
# phone: 0.00
# ----------
# Subotal: 1391.91
# Total:   1397.91 --> 1400
