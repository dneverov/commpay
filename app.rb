require_relative 'lib/param'
require_relative 'lib/billing'
require_relative 'lib/billing_store'
require_relative 'lib/render'

# Const
Tariffs = {
  water_cold: 40.48,
  water_hot: 198.19,
  energy: 5.47,
  gas: 56.69,
  phone: 1 #unused
}

OutputWidth = 24

# To hard save with defined entity_id. E.g. 'march_2020'. Set =nil to disable
BindedId = 'Linara'

# vars
@deltas = {
  water_cold: 6, #794, 799, 805
  water_hot: 3, #536,  539, 542
  energy: 91, #5546, 5649, 5740
  gas: 1,
  phone: 0 #unused
}

@previous_modifier = 6 #-39, -11

# The main App
billing = Billing.new(@deltas)
billing.modifier = @previous_modifier
billing.calculate

# Render
console_render = Render.new()
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
  file_name = 'data/billings.yml'
  billing_store = BillingStore.new(file_name)
  billing_store.save(billing)
  console_render.render_saved_file(billing_store.original_file_name)

  # # Load from file by entry
  # # Temporary
  # puts "\n-- Load --\n"
  # billing_loaded = billing_store.load('march_2020')
  # console_render.render(billing_loaded)
  # puts "\n-- End: Load --\n"
else
  # Temporary show Params
  # puts "\n# Temporary show Params #\n"
  # billing.billing_params.each do |b|
  #   puts b.inspect
  # end
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
