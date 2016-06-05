
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

  def start_training_with_patterns(patterns)

    classificationPatterns = self.classify_with_patterns(patterns)

    classificationPatterns.each { |key, patterns|

      svm   = SVM.new(@tolerance, @iteration, @c, @kernelType)

      matchPattern = classificationPatterns.select{|sKey,sValue| sKey != key}.values[0]

      svm.training_with_patterns(patterns,matchPattern)

      @svms << svm
    }

  end

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