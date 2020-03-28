class Param
  attr_accessor :name, :tariff, :value, :delta
  attr_reader :total

  def initialize(name, tariff = 0.0)
    @name = name
    @tariff = tariff
  end

  def calculate
    @total = delta * tariff
  end
end
