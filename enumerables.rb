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
end

