class TimePickerInput < SimpleForm::Inputs::Base

  def input
    template.content_tag(:div, class: 'input-field') do
      template.concat icon_prefix
      template.concat @builder.label(attribute_name, label_html_options)
      template.concat @builder.text_field(attribute_name, input_html_options)
    end
  end

  def icon_prefix
    "<i class='material-icons left prefix timepicker tooltipped' data-field='#{attribute_name}'></i>".html_safe
  end

  def label_html_options
    super.merge({class: 'active'})
  end

  def input_html_options
    super.merge({class: "#{attribute_name}"})
  end

end
