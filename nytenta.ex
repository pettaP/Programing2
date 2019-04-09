defmodule Tenta2 do

  def sum(list) do
    sum(list, 0)
  end

  def sum([], acc) do
    acc
  end

  def sum([h|t], acc) do
    sum(t, h + acc)
  end

  def new(val) do
    spawn_link(fn -> calc(val) end)
  end

  def calc(val) do
    receive do
      {:add, n} -> calc(val+n)
      {:sub, n} -> calc(val-n)
      {:req, pid} -> send(pid, {:total, val})
                      calc(val)
      :quit -> :ok
    end
  end

  def freq(_, []) do
    []
  end

  def freq(key, [{k, f}|rest]) do
    case k do
      ^key -> [{k, f+1}|freq(key, rest)]
      _ -> [{k, f}|freq(key, rest)]
    end
  end

  def fraq([], vals) do
    vals
  end

  def fraq([h | t], vals) do
    fraq(t, freq(h, vals))
  end

  def new do
    {:queue, [], []}
  end

  def enqueue(elem, {:queue, first, last}) do
    {:queue, first, [elem|last]}
  end

  def dequeue({:queue, [], []}) do
    :fail
  end

  def dequeue({:queue, [], last}) do
    dequeue({:queue, Enum.reverse(last), []})
  end

  def dequeue({:queue, [h | t], last}) do
    {:ok, h, {:queue, t, last}}
  end

  def app_queue({:queue, f1, l1}, {:queue, f2, l2}) do
    list1 = Enum.append(f1, Enum.reverse(l1))
    list2 = Enum.append(f2, Enum.reverse(l2))
    {:queue, Enum.append(list1, list2), []}
    end

    def str_to_list({:str, str}) do
      str
    end

    def str_to_list({:str, str1, str2}) do
      Enum.append(str_to_list(str1), str_to_list(str2))
    end

    def newcar(id, brand, color) do
      {:car, id, brand, color}
    end

    def color({:car, _, _, col}) do
      col
    end

    def paint({:car, id, brand, col}, newcol) do
      {:car, id, brand, newcol}
    end

    def once(list) do
      once(list, {0, 0})
    end

    def once([], res) do
      res
    end

    def once([h|t], {sum, len}) do
      once(t, {h+sum, 1+len})
    end

    def ack(0, n) do
      n+1
    end

    def ack(m, 0) do
      ack(m-1, 1)
    end

    def ack(m, n) do
      ack(m-1, ack(m, n-1))
    end

    def eval([h|t]) do
      eval(t, h)
    end

    def eval([], res) do
      res
    end

    def eval(['-', h|t], res) do
       eval(t, res - h)
    end

    def eval(['+', h|t], res) do
       eval(t, res + h)
    end

    def poly(val, var) do
      poly(val, var, 0)
    end

    def poly([], _, sum) do
      sum
    end

    def poly([h|pol], var, sum) do
      poly(pol, var, sum*var+h)
    end

    def newcoll() do
      spawn_link(fn -> collect([]) end)
    end

    def collect(list) do
      receive do
        {:done, from} -> send(from, Enum.reverse(list))
        x -> collect([x|list])
      end
    end

    def mon() do
      spawn_link(fn -> monitor_open([]) end)
    end

    def monitor_open([]) do
      ref = make_ref()
      receive do
        {:request, from} -> {:ok, ref}
                            monitor_closed(ref, [])
      end
    end

    def monitor_open([h|t]) do
      ref = make_ref
      send(h, {:ok, ref})
      monitor_closed(ref, t)
    end

    def monitor_closed(ref, q) do
      receive do
        {:request, from} -> :fail
                          monitor_closed(ref, [from] ++ q)
        {:release, ^ref} -> :ok
                          monitor_open(q)
      end
    end

    def decode(seq, tree)do
      decode(seq, tree, tree)
    end

    def decode(seq, {:char, char}, tree) do
      [char | decode(seq, tree, tree)]
    end

    def decode([], {:char, char}, _) do
      [char]
    end

    def decode([], _, _) do
      []
    end

    def decode([first|rest], {:huff, zero, one}, tree) do
      case first do
        1 -> decode(rest, one, tree)
        0 -> decode(rest, zero, tree)
      end
    end

    def huffman([{:freq, huff, _}]) do
      huff
    end

    def huffman([{:freq, {:char, char1}, f1 }, {:freq, {:char, char2}, f2} | rest]) do
      huff = {:huff, {:char, char1}, {:char, char2}}
    #  newlist = insert({:freq, huff, f1+f2}, rest)
      #huffman(newlist)
    end
"""
    def madelstart(pid) do
      spawn_link(fn -> mandelproc(pid) end)
    end

    def mandelproc(pid) do
      send(pid, {:request, self()})
      receive do
        {:calc, pixle, point, max, collector} ->
                          case mandel(point, max) do
                            0 -> send(collector, :fail)
                                  mandelproc(pid)
                            x -> col = color(x)
                                  send(collector, {:color, pixle, col})
                                  mandelproc(pid)
                          end
        :done -> :ok
      end
    end
"""

    def reduce([x]) do
      [x]
    end
    def reduce([h1, h1 | rest]) do
      reduce([h1 | rest])
    end

    def reduce([h1, h2 | rest]) do
      [h1 | reduce([h2 | rest])]
    end

    def ceasar([]) do
      []
    end

    def ceasar([32 | rest]) do
      [32 | ceasar(rest)]
    end

    def ceasar([var | rest]) do
    case var do
      x when x < 100 -> [(x-3+26) | ceasar(rest)]
      x -> [x-3 | ceasar(rest)]
      end
    end


end
