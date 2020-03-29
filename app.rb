require_relative 'lib/param'
require_relative 'lib/billing'
require_relative 'lib/billing_store'

# Const
Tariffs = {
  water_cold: 40.48,
  water_hot: 198.19,
  energy: 5.47,
  gas: 56.69,
  phone: 1 #unused
}

OutputWidth = 24

# vars
@values = {
  water_cold: 6, #794, 799, 805
  water_hot: 3, #536,  539, 542
  energy: 91, #5546, 5649, 5740
  gas: 1,
  phone: 0
}

@previous_modifier = 6 #-39, -11

@@billing_params = []

# The main App
billing = Billing.new(Tariffs, @values)
billing.modifier = @previous_modifier
billing.calculate

# Ask to Save to a File
print "\nSave to file? (y/N): "
save_file = gets.chomp

if ['y', 'yes'].include?(save_file.downcase)
  # Save the file
  file_name = 'data/billings.yml'
  billing_store = BillingStore.new(file_name)
  billing_store.save(billing)

  # Load from file by entry
  # billing_store.store.transaction do |bs|
  #   p bs.roots
  #   puts
  #   p bs.roots.last
  #   p bs[bs.roots.last]
  # end
else
  # Temporary show Params
  puts "\n# Temporary show Params #\n"
  @@billing_params.each do |b|
    puts b.inspect
  end
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
