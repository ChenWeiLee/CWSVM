class Kernel

  @kernelType = 'Linear'

  attr_accessor :arrayXi
  attr_accessor :arrayXj
  attr_accessor :sigma
  sigma = 1.0

  #init時請給訂kernel的方法
  def initialize(kernelMethod)
    @kernelType = kernelMethod.to_s
  end

  #新增KernelType的Getter
  def kernelType
    @kernelType
  end
  #新增KernelType的Setter
  def kernelType=(type)
    @kernelType = type.to_s
  end



  #請傳入兩個Array參數，裡面值得型態為Float
  def algorithmWithData(dataXiArray , dataXjArray)

    #檢查傳入的參數是否為Array型態
    arrayXi = dataXiArray.to_a
    arrayXj = dataXjArray.to_a

    case kernelType
      when "Linear"
        puts "Kernel is linear"
        self.kernelLinear
      else
        puts "Kernel is RBF"
        self.kernelRBF
    end
    
  end

  def kernelLinear()

    result = 0.0

    arrayXi.each_index do |index|
      result = result + arrayXi[index].to_f * arrayXj[index].to_f
    end

    return result
  end


  def kernelRBF

    result = 0.0

    arrayXi.each_index do |index|
      result = result + (arrayXi[index].to_f - arrayXj[index].to_f) **2
    end

    result = result ** (1.0/2) # => 開根號

    Math.exp(- (result ** 2)/-2*(sigma.to_f ** 2))
  end


end