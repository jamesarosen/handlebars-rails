## What ##

Use the awesome [Handlebars.js](https://github.com/wycats/handlebars.js)
both server- and client-side.

## Why ##

DRY. That's why.

## How ##

In `app/controllers/blogs_controller.rb`:

    BlogsController
      def show
        @blog = Blog.find(params[:id])
      end
    end

In `app/views/blogs/show.html.hbs`:

    <article>
      <header>
        <h1>{{{ blog/title }}}</h1>
      </header>
      {{{ blog/body }}}
      <footer>
        by {{{ rails "link_to" blog/author/name blog/author }}}
    </article>

### Usage Gotchas ###

Rails returns HTML-safe strings, but the string-safety information
isn't passed into Handlebars, so Handlebars re-escapes the content.
To get around this, use the triple-stash (`{{{ ... }}}`) when
using a Rails helper.
See [issue 2](https://github.com/jamesarosen/handlebars-rails/issues/#issue/2)

Names of Rails helpers must be quoted. This is because they don't
exist in the Handlebars context and are looked up in `ActionView`.
See [issue 3](https://github.com/jamesarosen/handlebars-rails/issues/#issue/3)

## Credits ##

Yehuda Katz did all the heavy lifting to get this off the ground,
both in terms of writing
[Handlebars.js](https://github.com/wycats/handlebars.js) and the
template handler here.
Additional huge props to Charles Lowell for
[therubyracer](https://github.com/cowboyd/therubyracer),
a *sine qua non* for this project.
