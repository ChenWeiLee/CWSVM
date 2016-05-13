# Dynamic loading and matching the PATH of files
$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require './pattern'

class SVM

  attr_accessor :iteration, :weights, :bais, :c, :tolerance, :alphas

  def initialize(tolerance_value = 0.001, iteration_value = 1000, c_value = 1)

    @tolerance = tolerance_value
    @iteration = iteration_value
    @c         = c_value

    bais      = 0.0
    weights   = []
    alphas    = []
    #if( someObjec.is_a? Float ), is_a method is like isClassKindOf.
  end

  def training(samples, targets)

    # 當輸入的參數不是 Array 或 為空陣列時 就不處理
    if !(samples.is_a? Array) || (samples.size == 0) || !(targets.is_a? Array)
        return
    end

    # 將預設的 W 設定成 0
    weights = Array.new(samples[0].size)
    # 將 Alphas 也都預設成 0
    alphas  = Array.new(samples.size)

  end

end




