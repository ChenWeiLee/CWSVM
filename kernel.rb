class Kernel

  @kernelType = 'Linear'

  arrayXi = []
  arrayXj = []

  #init時請給訂kernel的方法
  def initialize(kernelMethod)
    @kernelType = kernelMethod
  end

  #新增KernelType的Getter
  def kernelType
    @kernelType
  end
  #新增KernelType的Setter
  def kernelType=(type)
    @name = type
  end



  #請傳入兩個Array參數，裡面值得型態為Float
  def algorithmWithData(dataXiArray , dataXjArray)

    #檢查傳入的參數是否為Array型態
   if dataXiArray.class != Array.class && dataXjArray.class != Array.class
     return
   end

   arrayXi = dataXiArray
   arrayXj = dataXjArray

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

    arrayXi.size.Times do


    end

    return result
  end


  def kernelRBF

    result = 0.0

    return result
  end


end