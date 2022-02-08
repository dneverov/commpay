class Render
  attr_accessor :total_cell_sizes, :delta_cell_sizes
  # Full output width
  OutputWidth = I18n.t(:output_width, default: 30)
  MinFloatWidth = 8
  # Show the difference with the previous counters
  ShowDelta = true

  def render(billing)
    configure_row
    puts
    puts "\e[33m#{billing.name.center(OutputWidth)}\e[0m"
    puts hr

    billing.billing_params.each do |bp|
      key = I18n.t(:long, scope: [:billing, bp.name])
      billing_row = if ShowDelta
        formatted_float_with_delta(key, bp.delta, bp.total)
      else
        formatted_float( key, bp.total )
      end
      puts billing_row
    end

    puts hr
    puts formatted_total( I18n.t(:long, scope: [:billing, :subtotal]), billing.subtotal )
    puts formatted_total( I18n.t(:long, scope: [:billing, :total]), billing.straight_total )
    puts formatted_total("", billing.total)
  end

  def ask_to_pay(billing)
    suggested_total = suggest_to_pay(billing.total)
    # Ask to Round Total
    print I18n.t(:total_to_pay, scope: :ask_to, suggested_payment: suggested_total)
    to_pay = gets.chomp
    to_pay = suggested_total if to_pay.to_i <= 0
    to_pay
  end

  def render_to_pay(billing)
    # Move the cursor up N lines: \033[NA
    # Move the cursor forward N columns: \033[NC
    print "\033[1A\e[33m#{ formatted_total( I18n.t(:long, scope: [:billing, :payment]), billing.payment ) }     \e[0m"
    puts "\n"
    puts formatted_total( I18n.t(:long, scope: [:billing, :modifier]), billing.next_modifier )
  end

  def ask_to_save_file
    positive_answers = %w(y yes)
    # print "\nSave to file? (y/N): "
    print I18n.t(:question, scope: [:ask_to, :save_to_file], legend: I18n.t(:legend, scope: [:ask_to, :save_to_file]))
    save_file = gets.chomp

    positive_answers.include?(save_file.downcase)
  end

  def render_saved_file(file_name)
    print "\033[1A#{ I18n.t(:saved_file, scope: [:ask_to, :save_to_file]) } \e[32m`#{file_name}`\e[0m\n"
  end

  private

    def hr(w=OutputWidth)
      "-" * w
    end

    def set_total_cell_sizes
      # total cell widths:
      cw = {
        del: 5, # 1+3+1
        val: MinFloatWidth
      }
      cw[:key] = calculate_key_size(cw)
      self.total_cell_sizes = cw
    end

    def set_delta_cell_sizes
      # delta cell widths:
      cw = {
        del: 8, # 1+3+3+1
        dta: 3,
        val: MinFloatWidth
      }
      cw[:key] = calculate_key_size(cw)
      self.delta_cell_sizes = cw
    end

    def configure_row
      set_total_cell_sizes
      set_delta_cell_sizes if ShowDelta
    end

    # Calculates size for a key cell (E.g. "Cold Water...")
    def calculate_key_size(cell_widths)
      cells_sum = cell_widths.values.compact.inject(:+)
      OutputWidth - cells_sum
    end

    def formatted_float(key, value, options = {:delimeter => "|"})
      cw = self.total_cell_sizes
      format(" %-#{cw[:key]}s #{options[:delimeter]} %#{cw[:val]}.2f", key, value)
    end

    def formatted_float_with_delta(key, delta, value, options = {:delimeter => "|"})
      cw = self.delta_cell_sizes
      format(" %-#{cw[:key]}s #{options[:delimeter]} %#{cw[:dta]}d #{options[:delimeter]} %#{cw[:val]}.2f", key, delta, value)
    end

    def formatted_total(key, value)
      formatted_float(key, value, delimeter: ' ')
    end

    def suggest_to_pay(val)
      val.round(-2)
    end
end
