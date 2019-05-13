require 'middleman-core'

::Middleman::Extensions.register(:metaman) do
  require 'middleman-metaman/extension'
  ::Middleman::MetamanExtension
end
