class DatePickerInput < SimpleForm::Inputs::Base

  def input(wrapper_options)
    "#{icon_prefix} #{@builder.label(attribute_name)} #{@builder.text_field(attribute_name, input_html_options)}".html_safe
  end

  def input_html_options
    super.merge({ class: 'datepicker', type: 'date' })
  end

  def icon_prefix
    "<i class='material-icons left prefix'>date_range</i>".html_safe
  end

end