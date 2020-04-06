class Param
  attr_accessor :name, :tariff, :value, :delta
  attr_reader :total

  def initialize(name, tariff = 0.0, value = 0)
    @name = name
    @tariff = tariff
    @value = value
  end

  def calculate
    @total = sprintf("%.2f", delta * tariff).to_f
  end
end
