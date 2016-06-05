
require './svm'

class SVMManager

  attr_accessor :tolerance, :iteration, :c, :kernelType
  attr_accessor :svms

  def initialize(tolerance_value = 0.001, iteration_value = 1000, c_value = 1, kernel_Method = KernelType.new)

    @svms      = []
    @tolerance = tolerance_value
    @iteration = iteration_value
    @c         = c_value
    @kernelType = kernel_Method

  end

  def classify_data_with_svm(data)

    bestSVMResult = -1
    classifyResult = 0

    @svms.each { |svm|
      result = svm.classify_data(data)

      if result >= bestSVMResult
        bestSVMResult = result
        classifyResult = svm.mainTag
      end
    }

    return classifyResult

  end


  #將訓練資料丟入並且開始訓練多個SVM
  #使用one-versus-rest方式來做多分類
  def start_training_with_patterns(patterns)

    classificationPatterns = self.classify_with_patterns(patterns)

    classificationPatterns.each { |key, patterns|

      svm   = SVM.new(@tolerance, @iteration, @c, @kernelType)

      matchPattern = classificationPatterns.select{|sKey,sValue| sKey != key}.values[0]

      svm.training_with_patterns(patterns,matchPattern)

      @svms << svm
    }

  end

  #將訓練數據分類
  def classify_with_patterns(patterns)

    classificationPattern = Hash.new

    patterns.each { |pattern|
      classification = classificationPattern[pattern.expectation] ? classificationPattern[pattern.expectation] : Array.new()
      classification << pattern
      classificationPattern[pattern.expectation] = classification
    }

    return classificationPattern

  end
  
  
end