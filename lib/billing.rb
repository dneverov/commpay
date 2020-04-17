class Billing
  attr_accessor :name, :modifier
  attr_reader :subtotal, :total, :straight_total, :created_at, :billing_params, :payment, :next_modifier

  def initialize(values)
    @created_at = Time.now
    @name = (defined?(BindedId) ? BindedId : nil) || @created_at.strftime("%B %Y")
    @modifier = 0
    @@values = values
    @billing_params = []
  end

  def create_params(previous_billing)
    @modifier = previous_billing.next_modifier

    previous_billing.billing_params.each do |p|
      k = p.name
      billing_param = Param.new(k, Tariffs[k], @@values[k])
      billing_param.delta = CalculatedParameters.include?(k.to_s) ? (billing_param.value - p.value) : p.value
      billing_params << billing_param
    end
  end

  def calculate
    subtotal = 0
    billing_params.each do |p|
      p.calculate
      subtotal += p.total
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
