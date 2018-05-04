class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length == 1

    pivot = array.first
    left = []
    right = []

    (1...array.length).each do |idx|
      if array[idx] <= pivot
        left << array[idx]
      else
        right << array[idx]
      end
    end
    self.sort1(left) + [pivot] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1
    prc ||= Proc.new { |x, y| x <=> y }

    pivot_pos = self.partition(array, start, length, &prc)
    self.sort2!(array, start, pivot_pos-start, &prc)
    self.sort2!(array, start+pivot_pos+1, length-pivot_pos-1, &prc)
    
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    pivot_pos = start
    pivot = array[start]

    ((start+1)...(start+length)).each do |idx|
      if prc.call(pivot, array[idx]) > 0
        array[idx], array[pivot_pos+1] = array[pivot_pos+1], array[idx]
        pivot_pos+=1 
      end
    end
    array[start], array[pivot_pos] = array[pivot_pos], array[start]
    pivot_pos
  end
end
