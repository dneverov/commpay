# Const
Tariffs = {
  water_cold: 40.48,
  water_hot: 198.19,
  energy: 5.47,
  gas: 56.69,
  phone: 0 #unused
}

# vars
@values = {
  water_cold: 6, #794, 799, 805
  water_hot: 3, #536,  539, 542
  energy: 91, #5546, 5649, 5740
  gas: 1,
  phone: 1
}

@previous_modifier = 6 #-39, -11

def in_currency(value)
  format("%.2f", value)
end

def calculate
  total = 0
  @values.each do |k,v|
    calc = v * Tariffs[k]
    puts "#{k}: #{in_currency calc}"
    total += calc
  end

  puts "----------\nSubotal: #{ in_currency total }"
  puts "Total:   #{ in_currency(total+@previous_modifier) }"
end

calculate

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
