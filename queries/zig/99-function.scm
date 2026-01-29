(function_declaration) @context.function

(function_declaration
  body: (block) @context.body)

(test_declaration) @context.function

(test_declaration
  (block) @context.body)
