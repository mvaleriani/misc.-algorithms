class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |x, y| x <=> y }
  end

  def count
    @store.length
  end

  def extract
    val = @store[0]
    @store[0] = @store.pop

    BinaryMinHeap.heapify_down(@store, 0)
    val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length-1)
  end

  public
  def self.child_indices(len, parent_index)
    l_child = parent_index*2 + 1
    r_child = parent_index*2 + 2

    if len > r_child
      [l_child, r_child]
    elsif len > l_child
      [l_child]
    else
      []
    end
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index-1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc = prc || Proc.new { |x, y| x <=> y }
    heaped_down = false

    until heaped_down
      heaped_down = true
      parent = array[parent_idx]
      child_indices = BinaryMinHeap.child_indices(len, parent_idx)

      if child_indices.length == 1 && child_indices[0] < len 
        child_idx = child_indices[0]
        child = array[child_idx]
      elsif child_indices.length == 2 && child_indices[1] < len
        l_child = array[child_indices[0]]
        r_child = array[child_indices[1]]

        if prc.call(l_child, r_child) < 0
          child_idx = child_indices[0]
          child = l_child
        else
          child_idx = child_indices[1]
          child = r_child
        end
      else
        child = nil
      end

      if child == nil
        break
      elsif prc.call(parent, child) > 0
        heaped_down = false
        array[child_idx] = parent
        array[parent_idx] = child
        
        parent_idx = child_idx
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc = prc || Proc.new { |x, y| x <=> y }
    heaped_up = false

    while heaped_up == false && child_idx.between?(1, len)
      heaped_up = true
      child = array[child_idx]
      parent_idx = self.parent_index(child_idx)
      parent = array[parent_idx]

      if prc.call(parent, child) >= 1
        heaped_up = !heaped_up
        array[child_idx] = parent
        array[parent_idx] = child

        child_idx = parent_idx
      end
    end 
    array
  end
end
