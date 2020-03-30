class Render
  def render(billing)
    puts "#\e[33m#{billing.name.center(OutputWidth-2)}\e[0m#"
    puts hr

    billing.billing_params.each do |bp|
      puts formatted_float(bp.name, bp.total)
    end

    puts hr
    puts formatted_total("Subtotal", billing.subtotal)
    puts formatted_total("Total", billing.total)
  end

  private

    def hr(w=OutputWidth)
      "-" * w
    end

    def formatted_float(key, value, options = {:delimeter => "|"})
      format(" %-11s #{options[:delimeter]} %8.2f", key, value)
    end

    def formatted_total(key, value)
      formatted_float(key, value, delimeter: ' ')
    end
end
