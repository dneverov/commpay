require 'yaml/store'
require_relative 'lib/param'

# Const
Tariffs = {
  water_cold: 40.48,
  water_hot: 198.19,
  energy: 5.47,
  gas: 56.69,
  phone: 1 #unused
}

# vars
@values = {
  water_cold: 6, #794, 799, 805
  water_hot: 3, #536,  539, 542
  energy: 91, #5546, 5649, 5740
  gas: 1,
  phone: 0
}

OutputWidth = 24

@previous_modifier = 6 #-39, -11

@@billing_params = []

class Billing
  attr_accessor :name, :modifier
  attr_reader :subtotal, :total

  def initialize(tariffs, values)
    @created_at = Time.now
    @name = @created_at.strftime("%B %Y")
    @modifier = 0
    @tariffs = tariffs
    @values = values
  end

  def calculate
    puts "##{name.center(OutputWidth-2)}#"
    puts hr
    subtotal = 0
    @values.each do |k,v|
      calc = v * Tariffs[k]
      puts formatted_float(k, calc)
      subtotal += calc
      # Do the same with Param
      billing_param = Param.new(k, Tariffs[k])
      billing_param.delta = v
      billing_param.calculate
      # billing_param.total = v * Tariffs[k]
      @@billing_params << billing_param

    end

    # Total
    @subtotal = sprintf("%.2f", subtotal).to_f
    @total = sprintf("%.2f", subtotal+modifier).to_f
    # Render
    puts hr
    puts formatted_total("Subtotal", @subtotal)
    puts formatted_total("Total", @total)
  end

  private

    def hr(w=OutputWidth)
      "-" * w
    end

    # TODO: remove (unused)
    # def in_currency(value)
    #   format("%.2f", value)
    # end

    def formatted_float(key, value, options = {:delimeter => "|"})
      format(" %-11s #{options[:delimeter]} %8.2f", key, value)
    end

    def formatted_total(key, value)
      formatted_float(key, value, delimeter: ' ')
    end
end

# The main App
billing = Billing.new(Tariffs, @values)
#billing.name = "March 2020 Billing"
billing.modifier = @previous_modifier
billing.calculate

# Ask to Save to a File
print "\nSave to file? (y/N): "
save_file = gets.chomp

if ['y', 'yes'].include?(save_file.downcase)
  # Save the file
  file_name = 'data/billings.yml'
  yaml_store = YAML::Store.new(file_name)

  yaml_store.transaction do
    yaml_store["billing"] = billing
  end
  puts "Saved file: '#{file_name}'"

  # Load from file by entry
  yaml_store.transaction do
    p yaml_store.roots
    puts
    p yaml_store.roots.last
  end
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
