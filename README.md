# Middleman Metaman
![Metman Logo](metaman.jpg)
By [Cache Ventures](https://cacheventures.com).

Metaman makes it easy to manage your meta tags on a Middleman site.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'middleman-metaman'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-metaman

## Configuration

Within the config.rb of the middleman project, include the line

```ruby
activate :metaman, host: 'https://domain.com'
```

## Usage

Put this in the head of your site

```erb
  <%= display_meta_tags %>
```

You can set meta tags using multiple methods. The order of priority from lowest
to highest is defaults (data/meta_tags.yml), translations, front matter,
page specific variables set via `set_meta_tags` in
a template.

## Setting Defaults

The defaults file lives in `data/meta_tags.yml`. You can set any meta tag you
would like. It will be converted to a hash and merged during page generation.
Nested parameters like `{ og: { title: 'My Title' } }` will become `og:title`.

## Setting via Templates

```erb
<% set_page_meta(title: 'My Title', og: { image: 'meta-image.png' } )
```

## Setting via Front Matter

Only the `title` and `description` can be set via Front Matter at this time.

## Setting via Translations

The gem will look for translations like so. If your page is called
`thank_you.html.erb` your translations should go under en > thank_you > meta > `...`

## Image Handling

Any key that includes `image` in it will automatically have the host prepended
and will use the `image_path` helper.

## Property / Name Attribute

This gem currently supports  generating meta tags using the
property attribute for any meta tags that start with `og:`, `music:`, `music:`, `video:`, `article:`, `book:`, `profile:`.
