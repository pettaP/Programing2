defmodule Moves do

  def single({:one, int}, {main, t1, t2}) do
    case int do
      x when x > 0 ->
        move = Foo.take(Enum.reverse(main), int)
        main = Foo.drop(Enum.reverse(main), int)
        {Enum.reverse(main), Foo.append(Enum.reverse(move), t1), t2}
      x when x < 0 -> {main, t1, t2}
      _ -> {main, t1, t2}
    end
  end

  def single({:two, int}, {main, t1, t2}) do
    case int do
      x when x > 0 ->
        move = Foo.take(Enum.reverse(main), int)
        main = Foo.drop(Enum.reverse(main), int)
        {Enum.reverse(main), t1, Foo.append(Enum.reverse(move), t2)}
      x when x < 0 -> {main, t1, t2}
      _ -> {main, t1, t2}
    end
  end

end
