defmodule Sem do

  def new(), do: spawn_link(fn -> semaphore(0) end)

  def semaphore(0) do
    receive do
      :release ->
        semaphore(1)
    end
  end

  def semaphore(n) do
    receive do
      {:request, ref, from} ->
          send(from, {:granted, ref})
          semaphore(n-1)
      :release ->
          semaphore(n+1)
      end
  end

  def request(semaphore) do
    ref = make_ref()
    send(semaphore, {:request, ref, self()})
    wait(semaphore, ref)
  end

  def wait(semaphore, ref) do
    receive do
      {:granted, ^ref} -> :ok
      {:granted, _} -> wait(semaphore, ref)
    after
      1000 -> send(semaphore, :release)
              :abort
    end
  end

end
