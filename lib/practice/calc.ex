defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> hd
    |> parse_float
    |> :math.sqrt()

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  def tag_tokens('+'), do: {:op, '+'}
  def tag_tokens('-'), do: {:op, '-'}
  def tag_tokens('*'), do: {:op, '*'}
  def tag_tokens('/'), do: {:op, '/'}
  def tag_tokens(num), do: {:num, parse_float(num)}

  def postfix([], [], post), do: post
  def postfix([], [op | ops], post), do: postfix([], ops, [op | post])

  def postfix([{:num, num} | toks], ops, post) do
    postfix(toks, ops, [{:num, num} | post])
  end

  def postfix([{:op, op} | toks], ops, post) do
    case {op, ops} do
      {op, []} ->
        postfix(toks, [op], post)
        {[]}
    end
  end
end
