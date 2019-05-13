require 'middleman-metaman/helpers'

module Middleman
  class MetamanExtension < Extension
    option :host, nil, 'Set host that the site will running at.'

    def initialize(app, options_hash={}, &block)
      super

      # place in class variable so helpers can access
      @@options = options
    end

    def self.options
      @@options
    end

    self.defined_helpers = [Middleman::Metaman::Helpers]
  end
end
