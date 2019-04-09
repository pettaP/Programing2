defmodule Splay do

  def update(nil, key, value) do
    {:node, key, value, left, right}
  end

  def update({:node, key, _, a, b}, key, value) do
    {:node, key, value, a, b}
  end

  def update({:node, rk, rv, zig, c}, key, value) when key < rk do
    {:splay, _, a, b} = spaly(zig, key)
    {:node, }
  end

  def update({:node, rk, rv, a, zag}, key, value) when key >= rk do
    {:splay, _, b, c} = spaly(zag, key)
    {:node, key, value, }
  end

  defp splay(nil, _) do
    {:splay, :na, nil, nil}
  end

  defp splay({:node, key, value, a, b}, key) do
    {:splay, key, a, b}
  end

end
