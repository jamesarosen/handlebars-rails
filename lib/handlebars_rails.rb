require 'v8'

module Handlebars
  class TemplateHandler

    JS = V8::Context.new do |js|
      js.load(File.join(Rails.root, 'vendor', 'javascripts', 'handlebars.js'))
      @handlebars = js['Handlebars']
      @templates  = js["Templates"] = js.eval("({})")
    end

    RAILS_HELPER = JS.eval(%{
      (function(helper) { 
        var params = Array.prototype.slice.call(arguments, 1);
        var av = this.__context__.fallback.actionview;
        return helper.apply(av, params);
      })
    })

    def self.call(template)
      # Here, we're sticking the compiled template somewhere in V8 where
      # we can get back to it
      begin
        @templates[template.identifier] = @handlebars.compile(template.source)
        %{
          fallback = { :actionview => self, :rails => ::HandlebarsTemplateHandler::RAILS_HELPER }
          HandlebarsTemplateHandler::JS.eval("Templates['#{template.identifier}']").call(assigns, fallback)
        }
      rescue V8::JSError => e
        Rails.logger.error("JS compilation error: #{e}#{e.backtrace(:javascript).join("\n  ")}")
        raise
      end
    end
  end
end

if defined?(ActiveSupport) && ActiveSupport.respond_to?(:on_load)
  ActiveSupport.on_load(:action_view) do
    ActionView::Template.register_template_handler(:hbs, ::Handlebars::TemplateHandler)
  end
end
