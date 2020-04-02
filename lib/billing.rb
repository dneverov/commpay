class Billing
  attr_accessor :name, :modifier
  attr_reader :subtotal, :total, :straight_total, :created_at, :billing_params, :payment, :next_modifier

  @@deltas = nil

  def initialize(deltas)
    @created_at = Time.now
    @name = @created_at.strftime("%B %Y")
    @modifier = 0
    @@deltas = deltas
    @billing_params = []
  end

  def calculate
    subtotal = 0
    @@deltas.each do |k,v|
      billing_param = Param.new(k, Tariffs[k])
      billing_param.delta = v
      billing_param.calculate
      billing_params << billing_param
      subtotal += billing_param.total
    end

    # Total
    @subtotal = sprintf("%.2f", subtotal).to_f
    @straight_total = sprintf("%.2f", subtotal+modifier).to_f
    @total = straight_total.round
  end

  def calculate_next_modifier(to_pay)
    @payment = to_pay.to_i
    @next_modifier = total - payment
  end
end
