
require './svm'

class SVMManager

  attr_accessor :tolerance, :iteration, :c, :kernelType

  def initialize(tolerance_value = 0.001, iteration_value = 1000, c_value = 1, kernel_Method = KernelType.new)

    @tolerance = tolerance_value
    @iteration = iteration_value
    @c         = c_value
    @kernelType = kernel_Method

  end

  def startTrainingWithPatterns(patterns)



  end

  def classifyWithPatterns(patterns)

    classificationPattern = Hash.new

    patterns.each { |pattern|

      if classificationPattern[pattern.expectation] == nil


      end



    }

  end
  
  
end