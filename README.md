# CommPay - Utility Bills

Just for Fun. (And for my personal convenience).

## How To start

### Initial setup

In the __lib/config.rb__ file:

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

#### 3. Define current `@variables`

```ruby
@values = {
  water_cold: 805,
  water_hot: 542,
  ...
}
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
