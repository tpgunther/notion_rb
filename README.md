## Description

Unofficial Ruby Client for Notion.so API v3. Based on https://github.com/jamalex/notion-py

This is a early version, some functionality is not developed yet

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'notion_rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notion_rb

## Usage

### Basic

```ruby
# Obtain the `token_v2` value by inspecting your browser cookies on a logged-in session on Notion.so
ENV['TOKEN_V2'] = '<some token>'

# Get the block
block = NotionRb::Block.new('https://www.notion.so/some_org/some-title-30d7f6e4c2284cbab860a6f40ed3372e')

# Some title
block.title

# It changes on real time on Notion
block.title = "A better title"
```

### Children

```ruby
# Gets children of the current block
block.children

# Creates and returns a new empty child block
block.create_child
```

### Delete and restore

```ruby
# Soft delete the current block
block.destroy

# Restores the block
block.restore
```

### Metadata

```ruby
# Get the block metadata, for example a code block
block.metadata
# {
#  properties: { 'language' => [['ruby']], 'title' => [['Code']] },
#  language: value['properties']['language'][0][0]
# }

# if the object is a row from a collection
block.metadata
# {:color=>"black", :block_color=>"white", "Tags"=>"new tag", "Name"=>"A new name"}
```

## Development

Run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tpgunther/notion_rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NotionRb project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tpgunther/notion_rb/blob/master/CODE_OF_CONDUCT.md).
