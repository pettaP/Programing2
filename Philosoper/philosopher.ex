defmodule Philosopher do

  def start(n, c1, c2, name, ctrl, rand) do
    pil = spawn_link(fn -> eat(n, c1, c2, name, ctrl, rand) end)
  end

  def sleep(t, name) do
      IO.puts("#{name} is sleeping!")
      :timer.sleep(:rand.uniform(t))
  end

  def eating(t, name) do
      IO.puts("#{name} is eating!")
      :timer.sleep(:rand.uniform(t))
  end

  def eat(0, _, _, name, ctrl, _) do
    IO.puts("---------------#{name} is not hungry any more!----------------")
    send ctrl, :done
  end

  def eat(n, c1, c2, name, ctrl, rand) do
    sleep(rand, name)
    case Chopstick.request(c1, 150) do
      :no ->
        eat(n, c1, c2, name, ctrl, rand)
      :ok ->
        IO.puts("#{name} received the first chopstick!")
        case Chopstick.request(c2, 150) do
          :no ->
            Chopstick.return(c1, name)
            eat(n, c1, c2, name, ctrl, rand)
          :ok ->
            IO.puts("#{name} received the second chopstick!")
            eating(rand, name)
            Chopstick.return(c1, name)
            Chopstick.return(c2, name)
            eat(n-1, c1, c2, name, ctrl, rand)
        end
    end
  end

end
