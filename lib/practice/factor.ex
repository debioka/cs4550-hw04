defmodule Practice.Factor do
  def factor(1) do
    []
  end

  def factor(num) do
    factor1 = Enum.find(2..num, fn x -> rem(num, x) == 0 end)
    [factor1 | factor(div(num, factor1))]
  end
end
