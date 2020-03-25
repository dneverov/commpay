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

@previous_modifier = 6 #-39, -11


class Billing
  attr_accessor :name, :modifier

  def initialize(tariffs, values)
    @name = "Unknown"
    @modifier = 0
    @tariffs = tariffs
    @values = values
  end

  def calculate
    puts "# #{name} #"
    puts hr
    total = 0
    @values.each do |k,v|
      calc = v * Tariffs[k]
      puts formatted_float(k, calc)
      total += calc
    end

    puts hr
    puts formatted_total("Subtotal", total)
    puts formatted_total("Total", total+modifier)
  end

  private

    def hr(w=24)
      "-" * w
    end

    # TODO: remove (unused)
    def in_currency(value)
      format("%.2f", value)
    end

    def formatted_float(key, value, options = {:delimeter => "|"})
      format(" %-11s #{options[:delimeter]} %8.2f", key, value)
    end

    def formatted_total(key, value)
      formatted_float(key, value, delimeter: ' ')
    end
end

# The main App
billing = Billing.new(@tariffs, @values)
billing.name = "March 2020 Billing"
billing.modifier = @previous_modifier
billing.calculate

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
