class Kernels

  attr_accessor :array_xi
  attr_accessor :array_xj
  attr_accessor :sigma
  attr_accessor :kernel_method

  attr_accessor :sigma

  #init時請給訂kernel的方法
  def initialize(kernel_method = "Linear")
    @kernel_method = kernel_method
    @sigma         = 1.0
  end

  #請傳入兩個Array參數，裡面值得型態為Float
  def run_with_data(data_xi , data_xj)

    #檢查傳入的參數是否為Array型態
    @array_xi = data_xi
    @array_xj = data_xj

    case @kernel_method
      when "Linear"
        puts "Kernel is linear"
        kernel_linear
      else
        puts "Kernel is RBF"
        kernel_RBF
    end
    
  end

  def kernel_linear
    result = 0.0
    array_xi.each_index do |index|
      result = result + array_xi[index] * array_xj[index]
    end
  end


  def kernel_RBF
    result = 0.0
    array_xi.each_index do |index|
      result = result + (array_xi[index] - array_xj[index]) ** 2
    end
    result = result ** (1.0/2) # => 開根號
    Math.exp(- (result ** 2)/-2*(@sigma ** 2))
  end


end