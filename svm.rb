# Dynamic loading and matching the PATH of files
$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require './pattern'
require './kernels'

class SVM

  attr_accessor :iteration, :weights, :bais, :c, :tolerance, :alphas, :trainingPatterns
  attr_accessor :kernel, :mainPattern, :matchPattern

  def initialize(tolerance_value = 0.001, iteration_value = 1000, c_value = 1)

    @tolerance = tolerance_value
    @iteration = iteration_value
    @c         = c_value


    bais           = 0.0
    weights        = []
    alphas         = []
    trainingPatterns = []
    kernel = Kernels.new()
    #if( someObjec.is_a? Float ), is_a method is like isClassKindOf.
  end

  def training(samples, targets,kernelMethod)

    kernel.kernel_method = kernelMethod

    # 當輸入的參數不是 Array 或 為空陣列時 就不處理
    if !(samples.is_a? Array) || (samples.size == 0) || !(targets.is_a? Array)
        return
    end

    # 將預設的 W 設定成 0
    weights = Array.new(samples[0].size)
    # 將輸入進來的Sample轉乘Pattern
    samples.each do |index|
      trainingPatterns[index] = Pattern.new(samples[index],targets[index],0)
    end

    trainFinish = true

    iteration.times do
      trainFinish = true
      trainingPatterns.each_with_index  do |pattern, index|

        if (self.checkPatternKKT(pattern) == false)
          trainFinish = false

          mainPattern = pattern
          matchPattern = self.randomSelectSecond(index)

          matchPatternNewAlpha = self.updateMatchPatternAlpha
          self.limitMatchPatternNewAlpha(matchPatternNewAlpha)

          mainPatternNewAlpha = self.updateMainPatternAlpha



        end

      end


      if trainFinish
        break
      end

    end

    put "Finish training Weight: #{weights} Bais:#{bais}"


  end

  #使用隨機挑選做第二點
  def randomSelectSecond(patternIndex)

    #挑出不為第一筆Pattern Index的數字
    index = (0..trainingPatterns.size).reject { |x| x==patternIndex }.to_a.sample(1)
    #回傳挑選出來的第二個點
    return trainingPatterns[index]
  end

  #更新挑選第二點的Alpha
  def updateMatchPatternAlpha

  end

  #更新後第二點的Alpha要符合在範圍內，如不符合則將值更新到極值
  def limitMatchPatternNewAlpha(newAlpha)

  end

  #更新第一點的Alpha
  def updateMainPatternAlpha
    
  end

  #更新權重
  def updateWeight
    
  end

  #更新偏權值
  def updateBais

  end
  
  #確認該點是否符合KKT條件
  def checkPatternKKT(pattern)

    value = pattern.expectation * pattern.error(bais,trainingPatterns,kernel.kernel_method)

    if (value < -tolerance && pattern.alpha < c) || (value > tolerance && pattern.alpha > 0)
        return false
    else
        return true
    end

  end

end




