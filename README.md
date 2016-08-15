# ConvertLoop API Client

A ruby client of the ConvertLoop REST API.

## Getting Started

### Ruby on Rails

1\. Install the gem in your `Gemfile`

```ruby
gem 'convertloop', '0.1.1'
```

2\. Run `bundle install` from the command line.

3\. Create a file `config/initializers/convertloop.rb`:

```ruby
ConvertLoop.configure(
  :app_id => 'your_app_id',
  :api_key => 'your_api_key'
)
```

### Ruby

1\. Install the gem

```ruby
gem install convertloop
```

2\. Configure the `ConvertLoop` object passing your credentials.

```ruby
require 'convertloop'

ConvertLoop.configure(
  :app_id => 'your_app_id',
  :api_key => 'your_api_key'
)
```
You are now ready to start calling the API methods!

## API Methods

### Creating or updating a person

You need to pass at least one of the following: `pid`, `user_id` or `email` to identify a user. Use `pid` when you are updating a guest of your site (you can obtain this value from the cookie `dp_pid`). User `user_id` to match the `id` of the user in your application.

```ruby
ConvertLoop.people.create_or_update(email: "german.escobar@convertloop.co", first_name: "German", last_name: "Escobar", plan: "free")
```

Any key different to `pid`, `user_id`, `email`, `first_seen_at`, `last_seen_at`, `add_tags`, and `remove_tags` will be treated as a **custom attribute** of the person.

You can add or remove tags using the `add_tags` and `remove_tags` keys:

```ruby
ConvertLoop.people.create_or_update(email: "german.escobar@convertloop.co", add_tags: ['Learn Something'], remove_tags: ['Lead'])
```

### Logging an event

You can log an event for any person:

```ruby
ConvertLoop.event_logs.send(name: "Billed", person: { email: "german.escobar@convertloop.co" }, metadata: { credits: 1000 }, ocurred_at: 1.hour.ago)
```

If you don't specify the `ocurred_at` key, the current time will be used. You can use the `person` key to add **custom attributes** and **tags** to that person.
