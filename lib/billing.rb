class Billing
  attr_accessor :name, :modifier
  attr_reader :subtotal, :total, :straight_total, :created_at, :billing_params, :payment, :next_modifier

  @@instances = []
  @@previous = nil

  def initialize(values)
    @created_at = Time.now
    @name = (defined?(BindedId) ? BindedId : nil) || @created_at.strftime("%B %Y")
    @modifier = 0
    @@values = values
    @billing_params ||= []
    @@instances << self
  end

  # See also: https://stackoverflow.com/questions/6145084/how-to-find-each-instance-of-a-class-in-ruby
  #   https://stackoverflow.com/questions/14318079/how-do-i-list-all-objects-created-from-a-class-in-ruby
  def self.all
    @@instances
  end

  def self.load_all(billing_store)
    @@instances = billing_store.load_all
  end

  def self.previous
    @@previous ||= all.last
  end

  def self.calculate_current
    current = all.last

    current.create_billing_params previous
    current.calculate
    current
  end

  def create_billing_params(previous_billing)
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
