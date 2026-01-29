(call_expression
  function: (identifier) @call.name) @call.node

(call_expression
  function: (field_expression
    member: (identifier) @call.name)) @call.node

(call_expression
  function: (call_expression)) @call.node
