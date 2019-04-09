defmodule Huffman do
  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text do 'this is something that we should encode' end
"""
  def test do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)
  end
  """

  def tree(sample) do
    freq = freq(sample)
    maketree(freq)
  end

  def maketree(sample) do
    case  sample do
      [x] -> sample
      _ -> sample = sort(sample)
      [first, second | tail] = sample
      {cfirst, ffirst}  = first
      {csecond, fsecond} = second
      newnode = {{cfirst, csecond}, (ffirst + fsecond)}
      maketree([newnode | tail])
    end
  end

  def insert(e, l) do
    {ch, value} = e
    if l == [] do
      [e]
    else
      [head | tail] = l
      {ch2, valuelist} = head
      case l do
        [] -> [e]
        l when value > valuelist -> [head | insert(e, tail)]
        l when value == valuelist -> [e | [ head | tail]]
        _ -> [e | l]
      end
    end
  end

  def encode_table([{head, _}]) do
    encode_table(head, [], [])

  end

  def encode_table({lleaf, rleaf}, seq, table) do

      rside = encode_table(rleaf, [1]++seq, table)
      lside = encode_table(lleaf, [0]++seq, table)
      rside ++ lside
  end

  def encode_table(x, seq, table) do
      [{x, seq}]
  end

  def sort(l) do
    sort(l, [])
  end

  def sort(x, l) do
    case x do
      [] -> l
      [head|tail]  ->  sort(tail, insert(head, l))
    end
  end

  def freq(sample) do
    freq(sample, [])
  end

  def freq([], freq) do
    freq
  end

  def freq([char | rest], freq) do
    freq(rest, update(<<char::utf8>>, freq))
  end

  def update(char, []) do
      [{char, 1}]
  end

  def update(char, freq) do
    [head|tail] = freq
    {c, value} = head
    if char == c do
      [{c, value + 1} | tail]
    else
      [head | update(char, tail)]
    end
  end

  def encode(text, table) do
    encode(text, table, [])
  end

  def encode([], table, code) do
    code
  end

  def encode(text, table, code) do
    [head | tail] = text
    newcode = [code | get_code(<<head::utf8>>, table)]
    encode(tail, table, newcode)
  end

  def get_code(char, []) do
    nil
  end
  
  def get_code(char, table) do
    [head | tail] = [table]
    case head do
      {var, list} when char == var -> list
      _ -> get_code(char, tail)
    end
  end

end
