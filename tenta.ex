defmodule Tenta do

  def transf(x, y, []) do
    []
  end

  def transf(x, y, [head | tail]) do
    case head do
      ^x -> transf(x, y, tail)
      _ -> [y * head | transf(x, y, tail)]
    end
  end
  def sum(list) do
    sum(list, 0)
  end

  def sum([], acc) do
    acc
  end

  def sum([h|t], acc) do
    sum(t, acc+h)
  end

  def mini(node) do
    if node = nil do
      :inf
    else
      mini(node, 0)
    end
  end

  def mini(nil, min) do
    min
  end

  def mini(node, min) do
    {Node, Value, Left, Right} = node
    minl = mini(Left, min)
    minr = mini(Right, min)
    if minl < min do
      min = minl
    else if minr < min do
      min = minr
    end
    end
    min
  end

  def cal(val) do
    id = spawn_link(fn -> calc(val) end)
  end

  def calc(val) do
    receive do
      {:add, N} -> calc(val+N)
      {:sub, N} -> calc(val-N)
      {:req, Pid} -> send(Pid, {:total, val})
                      calc(val)
    end
  end

  def start(val) do
    pid = spawn_link(fn -> state(val) end)
  end

  def state(val) do
    receive do
      {:set, newval} -> state(newval)
      {:get, pid} -> send(pid, {:val, val})
                      state(val)
      {:free, pid} -> send(pid, :ok)
    end
  end

  def set(pid, val) do
    send(pid, {:set, val})
    :ok
  end

  def get(pid) do
    send(pid, {:get, self()})
    receive do
      {:val, val} -> val
    end
  end

  def free(pid) do
    send(pid, {:free, self()})
    receive do
      :ok -> :free
    end
  end

  def freq(key, []) do
    [{key, 1}]
  end

  def freq(key, [{key, f}|tail]) do
    [{key, f+1}|tail]
  end

  def freq(key, [{k, f}|tail]) do
    [{k, f} | freq(key, tail)]
  end

  def fraq(keys) do
    fraq(keys, [])
  end

  def fraq([], list) do
    list
  end

  def fraq([{k, f} | tail], list) do
    fraq(tail, [f | list])
  end

  def new() do
    {:queue, [], []}
  end

  def enqueue(elem, {:queue, first, last}) do
    {:queue, first, [elem|last]}
  end

  def dequeue({:queue, [], []}) do
    :fail
  end

  def dequeue({:queue, [], last}) do
    [h | t] = Enum.reverse(last)
    {:ok, h, {:queue, t, []}}
  end

  def dequeue({:queue, [f | rest], last}) do
    {:ok, f, {:queue, rest, last}}
  end

  def make_lock() do
    pid = spawn_link(fn -> closed() end)
  end

  def closed() do
    receive do
      {pid, :s} -> send(pid, :ok)
        s()
      {pid, _} ->
        send(pid, :wrong)
        closed()
    end
  end

  def s() do
    receive do
      {pid, :e} -> send(pid, :ok)
        se()
      {pid, _} ->
        send(pid, :wrong)
        closed()
    end
  end

  def se() do
    receive do
      {pid, :s} -> send(pid, :ok)
        ses()
      {pid, _} ->
        send(pid, :wrong)
        closed()
    end
  end

  def ses() do
    receive do
      {pid, :a} -> send(pid, :ok)
        sesa()
      {pid, _} ->
        send(pid, :wrong)
        closed()
    end
  end

  def sesa() do
    receive do
      {pid, :m} ->
        send(pid, :open)
        open()
      {pid, _} ->
        send(pid, :wrong)
        closed()
    end
  end

  def open() do
    receive do
      :close -> closed()

    end
  end

  def try(pid, a) do
    send(pid, {self(), a})
    receive do
      :open -> IO.puts("Good job! Lock is open!")
      :ok -> IO.puts("Nice one!")
      :wrong -> IO.puts("Wrong code. Lock reset")
    end
  end

  def reduce(list) do
    reduce(list, nil)
  end

  def reduce([], _) do
    []
  end

  def reduce([h|t], prev) do
    case h do
      ^prev -> reduce(t, h)
        _ -> [h | reduce(t, h)]
    end
  end

  def encode([]) do
    []
  end

  def encode([32|t]) do
    [32|encode(t)]
  end

  def encode([h|t]) when h < 100 do
    [h-3+26 | encode(t)]
  end

  def encode([h | t]) do
    [h-3 | encode(t)]
  end

  def triss([]) do
    :false
  end

  def triss([{:card, _, value} | rest]) do
    case Enum.filter(rest, fn({:card, _, val}) ->  val == value end) do
      [_ |_] -> :true
      _ -> triss(rest)
    end
  end

  def newproc(x) do
    spawn_link(fn -> cell(x) end)
  end

  def cell(val) do
    receive do
      {:swap, new, from} ->
        send(from, {:ok, val})
        cell(new)
      {:set, new} ->
        cell(new)
    end
  end

  def create() do
    newproc(open)
  end

  def lock(cell) do
    send(cell, {:swap, :taken, self()})
    receive do
      {:ok, :open} -> :ok
      {:ok, : taken} -> lock(cell)
    end
  end

  def release(cell) do
    send(cell, {:set, open})
    :ok
  end

  def newsem(arg) do
    spawn_link(fn -> sem(arg) end)
  end

  def sem(arg) do
    receive do
      {:request, from} when arg > 0 ->
              send(from, :granted)
              sem(arg-1)
      {:request, from} when arg < 1 -> sem(arg)
      :release ->
              sem(arg+1)
    end
  end

  def make() do
    spawn_link(fn -> slut() end)
  end

  def slut() do
    receive do
      {:take, pid} ->
        send(pid, :granted)
        nun()
      _ -> slut()
    end
  end

  def nun() do
    receive do
      :release -> slut()
      _ -> nun()
    end
  end

  def critical(lock) do
    send(lock, {:take, self()})
    receive do
      :granted ->
          do_it()
          send(lock, :release)
    end
  end

end
