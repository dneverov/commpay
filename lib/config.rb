# Configuration file
#   Constants, Configs etc.

# Const
Tariffs = {
  water_cold: 40.48,
  water_hot: 198.19,
  energy: 5.47,
  gas: 56.69,
  phone: 1 #unused
}

CalculatedParameters = %w(water_cold water_hot energy)

OutputWidth = 24

# To hard save with defined entity_id. E.g. 'march_2020'. Set =nil to disable
BindedId = 'march_2020_apr'

# vars
# TODO: Load from a file
@values = { # March 2020
  water_cold: 805, #794, 799, 805
  water_hot: 542, #536,  539, 542
  energy: 5740, #5546, 5649, 5740
  gas: 1,
  phone: 0 #unused
}
