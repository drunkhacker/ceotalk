class HtmlPreviewInput < Formtastic::Inputs::TextInput
  def input_html_options
    super.merge(:class => "html-preview")
  end
end


