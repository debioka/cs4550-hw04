defmodule Practice.Palindrome do
  def palindrome?(word) do
    char_lst = String.split(word, "")
    List.starts_with?(char_lst, Enum.reverse(char_lst))
  end
end
