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

    
end

