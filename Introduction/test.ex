defmodule Test do
  def double(n) do
    n+n
  end
  def convert(n) do
    (n-32)/1.8
  end
  def arearec(n, m) do
    n*m
  end
  def areasqr(n) do
    arearec(n, n)
  end
  def radius(r) do
      r*r*3.14
  end
  def product(m, n) do
    if m == 0 do
      n*0
    else
      n + product(m-1, n)
    end
  end
  def expo(n, x) do
    if x == 1  do
      n
    else
      product(n, expo(n, x-1))
    end
  end
  def exp(x, y) do
    if y == 1 do
      x
    end
    if rem(y, 2) == 0 do
      expo(x, div(y, 2)) * expo(x, div(y, 2))
    end
    if rem(y, 2) != 0 do
      expo(x, y-1) * x
    end
  end
  def nth(n, l) do
    if n == 1 do
      [head|tail] = l
      head
    else
      [head|tail] = l
      nth(n-1, tail)
    end
  end
  def len(l) do
    case l do
      [] -> 0
      _ -> 1 + len(tl(l))
    end
  end
  def sum(l) do
    case l do
      [] -> 0
      _ -> hd(l) + sum(tl(l))
    end
  end
  def duplicate(l) do
    case l do
      [x] -> l ++ [x]
      [x|tail] -> [x] ++ [x] ++ duplicate(tail)
    end
  end
  def add(x, l) do
    case l do
      [] -> l ++ [x]
      [^x|tail] -> l
      [y|tail] -> [y] ++ add(x, tail)
    end
  end
  def remove(x, l) do
    case l do
      [] -> l
      [^x|tail] -> remove(x, tail)
      [y|tail] -> [y] ++ remove(x, tail)
    end
  end
  def unique(l) do
    case l do
      [] -> l
      [head|tail] -> [head] ++ unique(remove(head, tail))
    end
  end
  def pack(l) do
    case l do
      [] -> l
      [x] -> [x]
      [head|tail] -> [l -- remove(head, l)] ++ pack(remove(head, l))
    end
  end
  def firstreverse(l) do
    case l do
      [] -> l
      [head|tail] -> firstreverse(tail) ++ [head]
    end
  end
  def insert(e, l) do
    case l do
      [] -> [e] ++ l
      [head|tail] when e > head -> [head] ++ insert(e, tail)
      [head|tail] when e == head -> [e] ++ l
      _ -> [e] ++ l
    end
  end
  def isort(l) do
    isort(l, [])
  end
  def isort(x, l) do
    case x do
      [] -> l
      [head|tail]  ->  isort(tail, insert(head, l))
    end
  end
  """
  def msort(l) do
    case l do
      [] -> l
      _ -> {l1, l2} = msplit(l, [], [])
            merge(msort(l1), msort(l2))
    end
  end
  def msplit(l, l1, l2) do
    case l do
      [x, y] -> {[x], [y]}
      _ -> Enum.split(l, round(length(l)/2), round(length(l)/2), [])
    end
  end
  """
  def append(r, l) do
    r ++ l
  end
  def nreverse([]) do [] end
  def nreverse([h|t]) do
    r = nreverse(t)
    append(r, [h])
  end
  def reverse(l) do
    reverse(l,   [])
  end
  def reverse([], r) do  r end
  def reverse([h|t], r) do
    reverse(t, [h|r])
  end
  def bench() do
    ls = [16, 32, 64, 128, 256, 512]
    n = 100
    bench = fn(l)->
      seq = :lists.seq(1, l)
      tn = time(n, fn() -> nreverse(seq) end)
      tr = time(n, fn() -> reverse(seq) end)
      :io.format("lenght: ~10w nrev: ~8w us   rev: ~8w us~n", [1, tn, tr])
    end
    Enum.each(ls, bench)
  end
  def time(n, fun) do
    start = System.monotonic_time(:milliseconds)
    loop(n, fun)
    stop = System.monotonic_time(:milliseconds)
    (stop-start)
  end
  def loop(n, fun) do
    if n == 0 do
      :ok
    else
      fun.()
      loop(n-1, fun)
    end
  end
  def to_binary(0) do [] end
  def to_binary(n) do
    append(to_binary(div(n, 2)), [rem(n, 2)])
  end
  def to_better(n) do
    to_better(n, [])
  end
  def to_better(0, b) do
    b
  end
  def to_better(n, b) do
    to_better(div(n, 2), [rem(n, 2) | b])
  end
  def to_integer(x) do
    to_integer(x, 0)
  end
  def to_integer([x], n) do n + nth(1, [x]) end
  def to_integer([x|r], n) do
    to_integer( r , (n + (nth(1, [x]) * expo(2, len(r)))))
  end
  def fib(n) do
    case n do
      1 -> 1
      0 -> 0
      _ -> fib(n-1) + fib(n-2)
    end
  end
end
