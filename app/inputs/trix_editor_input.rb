# frozen_string_literal: true

class TrixEditorInput < ::SimpleForm::Inputs::TextInput
  def input(_wrapper_options = nil)
    out = ActiveSupport::SafeBuffer.new
    out << template.content_tag('trix-editor', '', input: input_class, class: 'trix-content')
    out << @builder.hidden_field(attribute_name, input_html_options)
  end
end
