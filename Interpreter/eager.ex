defmodule Eager do

  def eval_expr({:atm, id}, env) do
    {:ok, id}
  end

  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil -> :error
      {_, str}-> {:ok, str}
      end
  end

  def eval_expr({:cons, ls, rs}, env) do
    case eval_expr(ls, env) do
      :error -> :error
      {:ok, var} ->
        case eval_expr(rs, env) do
          :error -> :error
          {:ok, ts} -> {ts, var}
          end
      end
    end

  def eval_match(:ignore, _ , env) do
    {:ok, env}
  end

  def eval_match({:atm, id}, str, env) do
      {:ok, env}
  end

  def eval_match({:var, id}, str, env) do
    case Env.lookup(id, env) do
      nil ->
        {:ok, Env.add(id, str, env)}
      {_, ^str} ->
        {:ok, env}
      {_, _} ->
        :fail
      end
  end

  def eval_match({:cons, hp, tp}, {:cons, {_, id1}, {_, id2}}, env) do
    case eval_match(hp, id1, env) do
      :fail ->
          :fail
      {:ok, newenv } ->
          eval_match(tp, id2, newenv)
    end
  end

  def eval_match(_, _, _) do
    :fail
  end

  def eval_seq([exp], env) do
    eval_expr(exp, env)
  end

  def eval_seq([{:match, lhs, rhs} | tail], env) do
    case eval_expr(lhs, env) do
        :error ->

        {:ok, _} ->
          """
          vars = extract_vars(...)
          env = Env.remove(vars, ...)
          """
          case eval_match(lhs, rhs, env) do
            :fail ->
                :error
            {:ok, recenv} ->
                eval_seq(tail, recenv)
          end
      end
  end

  def eval(expr) do
    eval_seq(expr, [])
  end

end

[{{{{{"a", "s"}, {"o", {"b", {{{"z", "v"}, "g"}, "\n"}}}}, " "},
   {{{"l", {{{{"k", "j"}, "q"}, "d"}, {"\r", "c"}}}, {{"w", "h"}, {"u", "r"}}},
    {{"t", {{{"x", "m"}, "y"}, "i"}}, {"e", {{"f", "p"}, "n"}}}}}, 280}]
