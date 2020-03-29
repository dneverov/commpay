class Billing
  attr_accessor :name, :modifier
  attr_reader :subtotal, :total, :created_at

  def initialize(tariffs, values)
    @created_at = Time.now
    @name = @created_at.strftime("%B %Y")
    @modifier = 0
    @tariffs = tariffs
    @values = values
  end

  def calculate
    puts "##{name.center(OutputWidth-2)}#"
    puts hr
    subtotal = 0
    @values.each do |k,v|
      calc = v * Tariffs[k]
      puts formatted_float(k, calc)
      subtotal += calc
      # Do the same with Param
      billing_param = Param.new(k, Tariffs[k])
      billing_param.delta = v
      billing_param.calculate
      @@billing_params << billing_param
    end

    # Total
    @subtotal = sprintf("%.2f", subtotal).to_f
    @total = sprintf("%.2f", subtotal+modifier).to_f
    # Render
    puts hr
    puts formatted_total("Subtotal", @subtotal)
    puts formatted_total("Total", @total)
  end

  private

    def hr(w=OutputWidth)
      "-" * w
    end

    # TODO: remove (unused)
    # def in_currency(value)
    #   format("%.2f", value)
    # end

    def formatted_float(key, value, options = {:delimeter => "|"})
      format(" %-11s #{options[:delimeter]} %8.2f", key, value)
    end

    def formatted_total(key, value)
      formatted_float(key, value, delimeter: ' ')
    end
end
