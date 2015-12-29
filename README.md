# Glo

**Note** This gem has not been fully battletested and is still v0.0.1 so by all means play around with it but YMMV.

`gem 'glo', github: 'robodisco/glo'`

Glo helps you organize your business logic in your application into once central place rather than scattered across several models or even worst in your controller actions.

It has operations and pipelines (Ops and Pipes for short).

Let's use an operation to centralize all the logic pertaining to keeping an Order model and it's totals in your ecommerce app up to date every time it is updated.

In the update action in your controller 

```ruby
def update
    op = UpdateOrder.new(order_params)
    result = op.call

    if result.success?
        ...
    else
        ...
    end
end
```

Then create an operations directory in your project and create an operation class called UpdateOrder. You only need to define a call method and include `Glo::Op`

```ruby
# your_rails_app/app/operations/update_order.rb

class UpdateOrder
    include Glo::Op

    def call
        find_order
        calculate_line_items
        calculate_tax
        calculate_promotion_adjustments
        calculate_shipping
        update_order
    end

    private

    def find_order
      @order = Order.find(...)
    end

    def calculate_line_items
        total = 0
        @order.line_items.each do |i|
            total += i.amount
        end
        @order.line_item_total = total
    end

    def update_order
        unless @order.save!
            context.fail!
        end
        context.order = @order
    end
    
    ...
end

**That's it!**

## Context

In your operation class you have access to a context object which has all the params you passed during initialization. You can add more data to the context like so

context.message = "Hey!"

You can mark the operation as failed or success:

context.fail! 
context.fail? # true

context.success!
context.success? # true

## Creating a chain of operation with pipelines

You can also create a chain of operations via the Glo::Pipe 

Let's assume the updating of an order is a lot more complex and you want to split the various steps into their own operations.

Simply create operations for each step

```ruby
class CalculateLineItems
    include Glo::Op

    def call
        # logic goes here
    end
end

class CalculateTax
    include Glo::Op
    ...
end

class CalculateShipping
    ...
end
```

Then create and use a pipeline like so

```ruby
CreateOrder = Glo::Pipe.new([
    CalculateLineItems,
    CalculateTax,
    CalculateShipping
])

result = CreateOrder.call(params)
```

On #call each operation will be called and will be passed the same context on which they can add subsequent data. If at any time an operation fails the pipeline will stop and no further operations will be called.










