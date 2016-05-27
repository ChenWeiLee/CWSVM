# Dynamic loading and matching the PATH of files
$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require './pattern'
require './kernels'

class SVM

  attr_accessor :iteration, :weights, :bais, :c, :tolerance, :alphas, :trainingPatterns
  attr_accessor :kernel, :mainPattern, :matchPattern

  def initialize(tolerance_value = 0.001, iteration_value = 1000, c_value = 1, kernel_Method = KernelType.new)

    @tolerance = tolerance_value
    @iteration = iteration_value
    @c         = c_value


    @bais           = 0.0
    @weights        = []
    @alphas         = []
    @trainingPatterns = []
    @kernel = Kernels.new()
    @kernel.kernel_method = kernel_Method
    #if( someObjec.is_a? Float ), is_a method is like isClassKindOf.
  end

  def training(samples, targets, kernelMethod = KernelType.new)

    @kernel.kernel_method = kernelMethod

    # 當輸入的參數不是 Array 或 為空陣列時 就不處理
    if !(samples.is_a? Array) || (samples.size == 0) || !(targets.is_a? Array)
        return
    end

    # 將預設的 W 設定成 0
    @weights = Array.new(samples[0].size, 0)
    # 將輸入進來的Sample轉乘Pattern
    samples.each_index{ |index|
      @trainingPatterns[index] = Pattern.new(samples[index],targets[index],0)
    }

    trainFinish = true

    @iteration.to_i.times do
      trainFinish = true
      @trainingPatterns.each_with_index { |pattern, index|
        if (self.checkPatternKKT(pattern) == false)
          trainFinish = false

          @mainPattern = pattern
          @matchPattern = self.randomSelectSecond(index)

          matchPatternNewAlpha = self.updateMatchPatternAlpha
          matchPatternNewAlpha = self.limitMatchPatternNewAlpha(matchPatternNewAlpha)

          mainPatternNewAlpha = self.updateMainPatternAlpha(matchPatternNewAlpha)

          self.updateWeight(mainPatternNewAlpha, matchPatternNewAlpha)
          self.updateBais(mainPatternNewAlpha, matchPatternNewAlpha)

          @trainingPatterns[index].alpha = mainPatternNewAlpha

          indexMatch = @trainingPatterns.index { |pattern| pattern == @matchPattern }
          @trainingPatterns[indexMatch].alpha = matchPatternNewAlpha

          # puts "main #{index} match #{indexMatch}"
          # puts "In training Weight: #{@weights} Bais:#{@bais}"
          # puts "matchPatternNewAlpha: #{matchPatternNewAlpha} mainPatternNewAlpha:#{mainPatternNewAlpha}"
        end

      }

      if trainFinish
        break
      end

    end

    puts "Finish training Weight: #{@weights} Bais:#{@bais}"


  end

  #使用隨機挑選做第二點
  def randomSelectSecond(patternIndex)

    #挑出不為第一筆Pattern Index的數字
    index = (0...@trainingPatterns.size).reject { |x| x==patternIndex }.to_a.sample
    #回傳挑選出來的第二個點
    return @trainingPatterns[index]
  end

  #更新挑選第二點的Alpha
  def updateMatchPatternAlpha

    e1 = @mainPattern.error(@bais, @trainingPatterns,@kernel.kernel_method)
    e2 = @matchPattern.error(@bais, @trainingPatterns,@kernel.kernel_method)

    k11 = @kernel.run_with_data(@mainPattern.features, @mainPattern.features)
    k12 = @kernel.run_with_data(@mainPattern.features, @matchPattern.features)
    k22 = @kernel.run_with_data(@matchPattern.features, @matchPattern.features)

    return @matchPattern.alpha + (@matchPattern.expectation * (e1 - e2)) / (k11 + k22 - 2*k12)

  end

  #更新後第二點的Alpha要符合在範圍內，如不符合則將值更新到極值
  def limitMatchPatternNewAlpha(newAlpha)

    if @mainPattern.expectation * @matchPattern.expectation == 1
      min = [0, @mainPattern.alpha + @matchPattern.alpha - c].max
      max = [c, @mainPattern.alpha + @matchPattern.alpha].min
    else
      min = [0, @matchPattern.alpha - @mainPattern.alpha].max
      max = [c, c + @matchPattern.alpha - @mainPattern.alpha].min
    end


    if newAlpha > max
      newAlpha = max
    elsif newAlpha < min
       newAlpha = min
    end


    return newAlpha

  end

  #更新第一點的Alpha
  def updateMainPatternAlpha(newMatchAlpha)
    @mainPattern.alpha + (@matchPattern.expectation * @mainPattern.expectation * (@matchPattern.alpha - newMatchAlpha))
  end

  #更新權重
  def updateWeight(newMainAlpha, newMatchAlpha)

    @weights.each_with_index do |value, index|
      @weights[index] = value + (newMainAlpha - @mainPattern.alpha) * @mainPattern.expectation * @mainPattern.features[index] + (newMatchAlpha - @matchPattern.alpha) * @matchPattern.expectation * @matchPattern.features[index]
    end

  end

  #更新偏權值
  def updateBais(newMainAlpha, newMatchAlpha)

    mainBais  = @bais - @mainPattern.error(@bais,@trainingPatterns,@kernel.kernel_method) - @mainPattern.expectation * (newMainAlpha - @mainPattern.alpha) * @kernel.run_with_data(@mainPattern.features, @mainPattern.features) - @matchPattern.expectation * (newMatchAlpha - @matchPattern.alpha) * @kernel.run_with_data(@mainPattern.features, @matchPattern.features)
    matchBais = @bais - @matchPattern.error(@bais,@trainingPatterns,@kernel.kernel_method) - @mainPattern.expectation * (newMainAlpha - @mainPattern.alpha) * @kernel.run_with_data(@mainPattern.features, @matchPattern.features) - @matchPattern.expectation * (newMatchAlpha - @matchPattern.alpha) * @kernel.run_with_data(@matchPattern.features, @matchPattern.features)

    if newMainAlpha > 0 && newMainAlpha < c
      @bais = mainBais
    elsif newMatchAlpha > 0 && newMatchAlpha < c
      @bais = matchBais
    else
      @bais = (mainBais + matchBais) /2
    end

  end
  
  #確認該點是否符合KKT條件
  def checkPatternKKT(pattern)

    value = pattern.expectation * pattern.error(@bais,@trainingPatterns,@kernel.kernel_method)

    if (value < -1 * @tolerance.to_f && pattern.alpha < c) || (value > @tolerance.to_f&& pattern.alpha > 0)
        return false
    else
        return true
    end

  end

end




