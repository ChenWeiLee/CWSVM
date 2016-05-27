
class KernelType

  attr_reader :type
  attr_accessor :sigma

  def initialize(kernelType = :linear,sigmaValue = 1)
    @type = kernelType
    @sigma = sigmaValue
  end

  def linear
    @type = :linear
  end

  def rbf(sigmaValue = 1)
    @type = :rbf
    @sigma = sigmaValue
  end

end


class Kernels

  attr_accessor :array_xi
  attr_accessor :array_xj
  attr_accessor :sigma
  attr_accessor :kernel_method

  #init時請給訂kernel的方法
  def initialize(kernel_method = KernelType.new(:linear))
    @kernel_method = kernel_method
    @sigma         = 1.0
  end

  #請傳入兩個Array參數，裡面值得型態為Float
  def run_with_data(data_xi , data_xj)

    #檢查傳入的參數是否為Array型態
    @array_xi = data_xi.to_a
    @array_xj = data_xj.to_a


    case @kernel_method.type
      when :linear
        #puts "Kernel is linear"
        kernel_linear
      else
        #puts "Kernel is RBF"
        kernel_RBF
    end
    
  end

  def kernel_linear
    result = 0.0

    @array_xi.each_index { |index|
      result += @array_xi[index].to_f * @array_xj[index].to_f
    }
    result
  end


  def kernel_RBF
    result = 0.0
    array_xi.each_index do |index|
      result = result + (array_xi[index] - array_xj[index]) ** 2
    end
    result = result ** (1.0/2) # => 開根號
    Math.exp(- (result ** 2)/-2*(@kernel_method.sigma ** 2))
  end


end