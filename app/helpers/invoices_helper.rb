module InvoicesHelper

  def calculate_next_invoice_ranges(project)
    last_invoice = project.last_paid
    start_date = ""
    end_date = ""
    cycle = {"Weekly": 7, "Bi-Weekly": 14, "Monthly": 30, Custom: ""}
    unless last_invoice.nil?
      start_date = (last_invoice.end_date + 1.day).try(:strftime, "%F")
      end_date = (last_invoice.end_date + cycle[project.payment_cycle.to_sym].days).try(:strftime, "%F")
    end

    return [start_date, end_date]
  end

end
