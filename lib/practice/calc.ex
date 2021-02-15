defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> tokenize
    |> postfix
    |> eval_post

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  def tokenize(str) do
    str
    |> String.split(~r/\s+/)
    |> Enum.map(&tag_token/1)
  end

  def tag_token("+"), do: {:op, "+"}
  def tag_token("-"), do: {:op, "-"}
  def tag_token("*"), do: {:op, "*"}
  def tag_token("/"), do: {:op, "/"}
  def tag_token(num), do: {:num, parse_float(num)}

  def postfix(toks), do: postfix(toks, [], [])
  def postfix([], [], post), do: Enum.reverse(post)
  def postfix([], [op | ops], post), do: postfix([], ops, [op | post])

  def postfix([{:num, num} | toks], ops, post) do
    postfix(toks, ops, [{:num, num} | post])
  end

  def postfix([{:op, op} | toks], [], post) do
    postfix(toks, [{:op, op}], post)
  end

  def postfix([{:op, op} | toks], [{:op, op_stk} | ops], post) do
    cond do
      op in ["+", "-"] and op_stk in ["+", "-"] ->
        postfix([{:op, op} | toks], ops, [{:op, op_stk} | post])

      op in ["*", "/"] and op_stk in ["*", "/"] ->
        postfix([{:op, op} | toks], ops, [{:op, op_stk} | post])

      op in ["+", "-"] and op_stk in ["*", "/"] ->
        postfix([{:op, op} | toks], ops, [{:op, op_stk} | post])

      op in ["*", "/"] and op_stk in ["+", "-"] ->
        postfix(toks, [{:op, op} | [{:op, op_stk} | ops]], post)
    end
  end

  def eval_post(toks), do: eval_post(toks, [])
  def eval_post([], [sol | _]), do: sol

  def eval_post([{:num, num} | toks], stack) do
    eval_post(toks, [num | stack])
  end

  def eval_post([{:op, "+"} | toks], [n1 | [n2 | stack]]) do
    eval_post(toks, [n2 + n1 | stack])
  end

  def eval_post([{:op, "-"} | toks], [n1 | [n2 | stack]]) do
    eval_post(toks, [n2 - n1 | stack])
  end

  def eval_post([{:op, "*"} | toks], [n1 | [n2 | stack]]) do
    eval_post(toks, [n2 * n1 | stack])
  end

  def eval_post([{:op, "/"} | toks], [n1 | [n2 | stack]]) do
    eval_post(toks, [n2 / n1 | stack])
  end
end
