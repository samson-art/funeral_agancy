class DatePickerInput < SimpleForm::Inputs::Base

  def input
    template.content_tag(:div, class: 'input-field') do
      template.concat icon_prefix
      template.concat @builder.label(attribute_name)
      template.concat @builder.text_field(attribute_name, input_html_options)
    end
  end

  def icon_prefix
    "<i id='deceased_attributes_#{attribute_name}' class='material-icons tooltipped left prefix showpicker' data-tooltip='Show calendar'>date_range</i>".html_safe
  end

  def input_html_options
    super.merge({class: 'pickdate'})
  end

end