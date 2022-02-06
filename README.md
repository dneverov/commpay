# CommPay - Utility Bills

Just for Fun. (And for my personal convenience).

## How To start

### Initial setup

In the _lib/config.rb_ file:

#### 1. Define Tariffs

```ruby
Tariffs = {
  water_cold: 40.48,
  water_hot: 198.19,
  ...
}
```

#### 2. Setup `BindedId` const:
- `nil` (or comment out) -- for a new record;
- `<some name>` *(Eg. 'march_2020')* -- to work with existent _entity_ (for testing purposes).

```ruby
# To hard save with defined entity_id.
#   E.g. 'march_2020'. Set =nil to disable
BindedId = nil
```

#### 3. Define current variables

In the end of _data/values.yml_ file add your current values.  
E.g.:

```YAML
march_2020_values:
  water_cold: 805
  water_hot: 542
  energy: 5740
  gas: 1
  phone: 0
```
#### 4. Bundler

If Bundler not installed:

```bash
gem install bundler
```

then:

```bash
bundle install
```

#### 5. Localization
In the _lib/config.rb_ file set `I18n.locale` to `:en` | `:ru`.  
E.g.:

```ruby
I18n.locale = :ru
```

### Run App

From project root:

```bash
ruby app.rb

```

<!-- ## For developers

Actually -- for myself =)

see: https://trello.com/b/c4gWvDF9/commpay
-->
