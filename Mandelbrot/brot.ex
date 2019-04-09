defmodule Brot do

  def mandelbrot(c, m) do
    z0 = Cmplex.new(0, 0)
    i = 0
    test(i, z0, c, m)
  end

  def test(i, zn, c, m) do
    if Cmplex.abs(zn) > 2 do
      i
    else
      if i == m do
        0
      else
        znth = Cmplex.add(Cmplex.sqr(zn), c)
        test(i+1, znth, c, m)
      end
    end
  end

end
