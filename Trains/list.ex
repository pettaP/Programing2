defmodule Foo do

  def take(list, n) do
    take(list, n-1, [])
  end

  def take([], _, _) do
    :fail
  end

  def take([first | rest], 0, sofar) do
    Enum.reverse([first | sofar])
  end

  def take([first | rest], n, sofar) do
    take(rest, n-1, [first | sofar])
  end

  def drop([], _) do
    :fail
  end

  def drop([first | rest], 1) do
    rest
  end

  def drop([first | rest], n) do
    drop(rest, n-1)
  end

  def append(list1, list2) do
    appenrev(Enum.reverse(list1), list2)
  end

  def appenrev([], list2) do
    list2
  end

  def appenrev([h | rest], list2) do
    appenrev(rest, [h | list2])
  end

  def member([], key) do
    :false
  end

  def member([h | t], key) do
    case h do
      ^key -> :true
      _ -> member(t, key)
    end
  end

  def position(list, key) do
    position(list, key, 1)
  end

  def position([], _, _) do
    :fail
  end

  def position([h | t], key, acc) do
    case h do
      ^key -> acc
      _ -> position(t, key, acc+1)
    end
  end

end
