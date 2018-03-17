# Rails notes

#### Version
Ruby | Rails
---- | -----
2.3.3 | 5.1.5

### ActiveRecord Validation
- In Rails, model-level validations are the best way to ensure that only valid data is saved into your database.
- The non-bang and bang(`xxx!`) versions of `create`, `save` and `update` methods trigger validation and will only save the object to database if the object is valid. But there are many other methods that don't trigger validation, for example `touch`, `update_all`, etc. However, you can trigger validation yourself using `valid?` method.

