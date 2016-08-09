class PhotoInput < SimpleForm::Inputs::Base

  def input(wrapper_options)
    "#{field} #{path}".html_safe
  end

  def path
    template.content_tag :div, class: 'file-path-wrapper' do
      "<input class='file-path validate truncate' type='text' placeholder: 'Upload a photo'>".html_safe
    end
  end

  def field
    template.content_tag :div, class: 'btn btn-small' do
      template.concat span_title
      template.concat @builder.file_field(attribute_name)
    end
  end

  def span_title
    template.content_tag :span do
      "File"
    end
  end

end