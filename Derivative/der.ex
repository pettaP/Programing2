defmodule Der do

  @type literal() :: {:const, number()}
                    | {:const, atom()}
                    | {:var, atom()}

  @type expr() :: {:add, expr(), expr()}
                    | {:mul, expr(), expr()}
                    | {:exp, expr(), expr()}
                    | literal()

  def deriv({:const, _}, _), do: {:const, 0}

  def deriv({:var, v}, v), do: {:const, 1}

  def deriv({:var, y}, _), do: {:var, y}

  def deriv({:mul, e1, e2}, v), do: e1 * deriv(e2) + deriv(e1) * e2

  def deriv({:add, e1, e2}, v), do: deriv(e1) + deriv(e2)

  def deriv({:mul, {:const, c1}, {:exp, {:var, v}, {:const, c2}}}) do
    {:mul, {:cont, c1*c2}, {:exp, {:var, v}, {:const, c2-1}}}
  end

end
