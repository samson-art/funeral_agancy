class TimePickerInput < SimpleForm::Inputs::Base

  def input(wrapper_options)
    "#{icon_prefix} #{@builder.text_field(attribute_name, {class: 'timepicker', type: 'time'})}".html_safe
  end

  def icon_prefix
    "<i class='material-icons left prefix'>access_time</i>"
  end

end
