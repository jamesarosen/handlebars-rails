require 'handlebars-rails/version'
require 'handlebars-rails/v8'
require "active_support"

module Handlebars
  class TemplateHandler

    def self.js
      handlebars = File.join(Rails.root, "vendor", "javascripts", "handlebars.js")

      unless File.exists?(handlebars)
        raise "Could not find handlebars.js. Please copy it to #{handlebars}"
      end

      Thread.current[:v8_context] ||= begin
        V8::Context.new do |js|
          js.load(handlebars)
          js.eval("Templates = {}")

          js["puts"] = method(:puts)

          js.eval(%{
            Handlebars.registerHelper('helperMissing', function(helper) {
              var params = Array.prototype.slice.call(arguments, 1);
              return actionview[helper].apply(actionview, params);
            })
          })
        end
      end
    end

    def self.call(template)
      # Here, we're sticking the compiled template somewhere in V8 where
      # we can get back to it
      js.eval(%{Templates["#{template.identifier}"] = Handlebars.compile(#{template.source.inspect}) })

      %{
        js = ::Handlebars::TemplateHandler.js
        js['actionview'] = self
        js.eval("Templates['#{template.identifier}']").call(assigns)
      }
    end

  end
end

ActiveSupport.on_load(:action_view) do
  ActionView::Template.register_template_handler(:hbs, ::Handlebars::TemplateHandler)
end
