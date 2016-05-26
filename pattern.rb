class Pattern

  attr_accessor :features    # 數據特徵值     
  attr_accessor :expectation # 期望輸出值
  attr_accessor :alpha  

  def initialize(data_features, expectation_target, alpha_value)
    @features    = data_features.to_a # Why needs to_a ?
    @expectation = expectation_target.to_f
    @alpha       = alpha_value.to_f
    @kernel      = Kernels.new()
  end

  #bais 為目前此SVM的Bais
  #all_points是一個裝Pattern型態的Array
  #kernel要傳入Kernel class 來做kernel的計算
  def error(bais = 0.0, all_points, kernel_type)
    @kernel.kernel_method = kernel_type == nil ? "Linear" : kernel_type
    error_value = 0.0

    all_points.each{ |pattern|
      error_value += (pattern.expectation * pattern.alpha * @kernel.run_with_data(pattern.features, @features))
    }

    error_value += bais - expectation
  end

  def update_alpha(new_alpha)
    @alpha = new_alpha.to_f
  end
  
end