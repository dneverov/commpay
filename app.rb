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
  water_cold: 5, #794
  water_hot: 3, #536
  energy: 105, #5546
  gas: 1,
  phone: 1
}

@previous_modifier = -39

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

# water_cold: 202.39999999999998
# water_hot: 594.5699999999999
# energy: 574.35
# gas: 56.69
# phone: 0
# ----------
# Subotal: 1428.01
# Total:   1389.01
