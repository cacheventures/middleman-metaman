require 'middleman-core'
require 'active_support/core_ext/hash/indifferent_access'

::Middleman::Extensions.register(:metaman) do
  require 'middleman-metaman/extension'
  ::Middleman::MetamanExtension
end
