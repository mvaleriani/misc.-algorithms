require_relative "heap"

class Array
  def heap_sort!
    (1...self.length).each do |idx|
      BinaryMinHeap.heapify_up(self, idx) { |x, y| x <=> y }
    end

    (self.length-1).downto(0) do |idx|
      self[0], self[idx] = self[idx], self[0]
      BinaryMinHeap.heapify_down(self, 0, idx) { |x, y| x <=> y }
    end
    self.reverse!  
  end
end
