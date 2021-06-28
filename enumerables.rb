####### first line
class Array
    def my_each(&prc)
        # (0...self.length).to_a
        i = 0
        while i < self.length
            self[i] = prc.call(self[i])
        end
        self
    end
    
    def my_select(&prc)
        arr =[]
        self.each do |ele|
            arr << ele if prc.call(ele)
        end
        arr
    end

    def my_reject(&prc)
        arr =[]
        self.each do |ele|
            arr << ele if !prc.call(ele)
        end
        arr
    end

    def my_any?(&prc)
        self.each {|ele| return true if prc.call(ele)}
        false
    end

    def my_all?(&prc)
        self.each {|ele| return false if !prc.call(ele)}
        true
    end

    def my_flatten
        #return [self] if !self.is_a?(Array)

        self.inject([]) do |acc, ele|
            if !ele.is_a?(Array)
                acc += [ele]
            else
                acc += ele.my_flatten
            end
        end 
    end
    #p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

    def my_zip(*args)
        arr = Array.new(self.length) { Array.new }
        self.each_with_index do |ele, i|
            arr2 = []
            arr2 << ele
            args.each_with_index do |ele2, j|
                arr2 << args[j][i]
            end
            arr[i] += arr2 if arr2.length != 0
        end
        arr
    end

    
end

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
puts "*" * 20
c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

