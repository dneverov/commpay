class Render
  MinFloatWidth = 8

  def render(billing)
    puts "\e[33m#{billing.name.center(OutputWidth)}\e[0m"
    puts hr

    billing.billing_params.each do |bp|
      puts formatted_float(bp.name, bp.total)
    end

    puts hr
    puts formatted_total("Subtotal", billing.subtotal)
    puts formatted_total("Total", billing.straight_total)
    puts formatted_total("", billing.total)
  end

  def ask_to_pay(billing)
    suggested_total = suggest_to_pay(billing.total)
    # Ask to Round Total
    print "Total to Pay (#{suggested_total}): "
    to_pay = gets.chomp
    to_pay = suggested_total if to_pay.to_i <= 0
    to_pay
  end

  def render_to_pay(billing)
    # Move the cursor up N lines: \033[NA
    # Move the cursor forward N columns: \033[NC
    print "\033[1A\e[33m#{ formatted_total("To Pay", billing.payment) }     \e[0m"
    puts "\n"
    puts formatted_total("Mod", billing.next_modifier)
  end

  def ask_to_save_file
    positive_answers = %w(y yes hola)
    print "\nSave to file? (y/N): "
    save_file = gets.chomp

    positive_answers.include?(save_file.downcase)
  end

  def render_saved_file(file_name)
    print "\033[1ASaved file: \e[32m`#{file_name}`\e[0m\n"
  end

  private

    def hr(w=OutputWidth)
      "-" * w
    end

    def formatted_float(key, value, options = {:delimeter => "|"})
      format(" %-#{OutputWidth - MinFloatWidth - 5}s #{options[:delimeter]} %8.2f", key, value)
    end

    def formatted_total(key, value)
      formatted_float(key, value, delimeter: ' ')
    end

    def suggest_to_pay(val)
      val.round(-2)
    end
end
