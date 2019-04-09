defmodule Color do

  def convert(depth, max) do
      frac = depth / max
      sum = frac * 4
      section = trunc(sum)
      offset = trunc(255 * (sum - section))
      case section do
        0 -> {:rgb, offset, 0, 0}
        1 -> {:rgb, 255, offset, 0}
        2 -> {:rgb, 255-offset, 255, 0}
        3 -> {:rgb, 0, 255, offset}
        4 -> {:rgb, 0, 255-offset, 255}
      end
  end

end
