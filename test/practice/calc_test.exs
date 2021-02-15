defmodule Practice.CalcTest do
  use ExUnit.Case
  import Practice.Calc

  test "parse float" do
    assert parse_float("5.0") == 5.0
    assert parse_float("5") == 5.0
  end

  test "split expr" do
    assert String.split("5 + 3", ~r/\s+/) == ["5", "+", "3"]
  end

  test "tag token" do
    assert tag_token("+") == {:op, "+"}
    assert tag_token("5") == {:num, 5.0}
  end

  test "tokenize" do
    assert tokenize("5 + 3") == [{:num, 5}, {:op, "+"}, {:num, 3}]
  end

  test "infix to postfix" do
    expr1 =
      "5 + 3"
      |> tokenize
      |> postfix

    assert expr1 == [{:num, 5.0}, {:num, 3.0}, {:op, "+"}]
  end
end
