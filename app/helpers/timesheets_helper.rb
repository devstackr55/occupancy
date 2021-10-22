module TimesheetsHelper
  def color_pallet(type)
    color = {
      "Development": "#198754",
      "Client Meeting": "#0d6efd",
      "Internal Meeting": "#0dcaf0",
      "Client Interview": "#ffc107",
      "Interview": "#6c757d",
      "Other": "#212529"
    }

    return color[type.to_sym]
  end
end
