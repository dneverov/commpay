# Configuration file
#   Constants, Configs etc.

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
BindedId = nil
