class ImagePreviewInput < Formtastic::Inputs::StringInput
  def input_html_options
    super.merge(:class => "image-preview")
  end
end

