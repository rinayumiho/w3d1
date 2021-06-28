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

    def my_rotate(n = 1)
        arr = []
        n %= self.length
        n += self.length if n < 0
        (0...self.length).each {|i| arr << self[(i+n)%self.length]}
        arr
    end

    def my_join(sep = "")
        str = ""
        self.each do |ele|
            str += ele + sep
        end
        return str.chop if sep != ""
        str
    end

    def my_reverse
        return self if self.length == 1
        [self[-1]] + self[0...-1].my_reverse
    end
    
end

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
