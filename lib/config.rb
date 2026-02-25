# Configuration file
#   Constants, Configs etc.

require 'i18n'

# Tariffs = {
#   water_cold: 40.48,
#   water_hot: 198.19,
#   energy: 5.47,
#   gas: 56.69,
#   phone: 1 #unused
# }

# August 2020

# Tariffs = {
#   water_cold: 42.30,
#   water_hot: 205.15,
#   energy: 5.66,
#   gas: 58.43,
#   phone: 1 #unused
# }

# August 2021

# Tariffs = {
#   water_cold: 43.57,
#   water_hot: 211.67,
#   energy: 5.92,
#   gas: 60.18,
#   phone: 1 #unused
# }

# August 2022

# Tariffs = {
#   water_cold: 45.88,
#   water_hot: 223.04,
#   energy: 6.17,
#   gas: 60.18,
#   phone: 1 #unused
# }

# January 2023

# Tariffs = {
#   water_cold: 50.93,
#   water_hot: 243.16,
#   energy: 6.43,
#   gas: 74.70,
#   phone: 1 #unused
# }

# August 2024

# Tariffs = {
#   water_cold: 59.80,
#   water_hot: 272.14,
#   energy: 6.99,
#   gas: 80.59,
#   phone: 1 #unused
# }

# August 2025

# Tariffs = {
#   water_cold: 65.77,
#   water_hot: 312.5,
#   energy: 7.87, # нет платёжки. надо будет проверить
#   gas: 80.59,
#   phone: 1 #unused
# }

# January 2026 (from December 2025)

# Tariffs = {
#   water_cold: 65.77,
#   water_hot: 312.5,
#   energy: 7.87,
#   gas: 82.00,
#   phone: 1 #unused
# }

# February 2026

Tariffs = {
  water_cold: 66.87,
  water_hot: 317.71,
  energy: 8,
  gas: 82.00,
  phone: 1 #unused
}

CalculatedParameters = %w(water_cold water_hot energy)

# To hard save with defined entity_id. E.g. 'march_2020'. Set =nil to disable
BindedId = nil

I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]
I18n.default_locale = :en # (note that `en` is already the default!)
I18n.locale = :ru
