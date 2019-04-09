defmodule Cmplex do

  def new(r, i) do
    {r, i}
  end

  def add(a, b) do
    {ra, ia} = a
    {rb, ib} = b
    {ra+rb, ia+ib}
  end

  def sqr(a) do
    {r, i} = a
    {(r*r)-(i*i), (2*r*i)}
  end

  def abs(a) do
    {r, i} = a
    sum = (r*r) + (i*i)
    :math.sqrt(sum)
  end
  
end
