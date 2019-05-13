require 'middleman-metaman/helpers'

module Middleman
  class MetamanExtension < Extension
    self.defined_helpers = [Middleman::Metaman::Helpers]
  end
end
