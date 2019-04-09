defmodule Chopstick do

  def start() do
    stick = spawn_link(fn -> available() end)
  end

  defp available() do
    receive do
      {:request, from} ->
          send(from, :granted)
          gone()
      :quit -> :ok
    end
  end

  defp gone() do
    receive do
      {:return, from} ->
        send from, :ok
        available()
      {:request, from} ->
        send from, :no
        gone()
      :quit -> :ok
    end
  end

  def request(stick, timeout) do
    send stick, {:request, self()}
    receive do
      :granted -> :ok
      :no -> :no
    end
  end

  def return(stick, name) do
    send stick, {:return, self()}
      receive do
        :ok -> :returned
      end
  end

  def quit(stick) do
    send stick, :quit
    receive do
      :ok -> :ok
    end
  end

end
