defmodule Env do

  def new() do
    []
  end

  def add(id, str, env) do
    [{id, str} | env]
  end

  def lookup(id, []) do
    nil
  end

  def lookup(id, env) do
    [head|tail] = env
    {atom, _} = head
    if atom == id do
      head
    else
      lookup(id, tail)
    end
  end

  def remove([], env) do
    env
  end

  def remove(ids, env) do
    [head|tail] = ids
    newenv = delete(head, env)
    remove(tail, newenv)
  end

  def delete(id, []) do
    []
  end

  def delete(id, env) do
    [head|tail] = env
    {atom, _} = head
    if atom == id do
      delete(id, tail)
    else
      [head|delete(id, tail)]
    end
  end
end
