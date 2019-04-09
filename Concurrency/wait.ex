defmodule Wait do

  def hello do
    receive do
      x -> IO.puts("aaaa! surprise, a message: #{x}")
    end
  end
  
end
