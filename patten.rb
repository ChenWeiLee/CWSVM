class Patten

  attr_accessor :dataX
  attr_accessor :alpha
  attr_accessor :expectation

  def initialize(dataXArray,expectationY,alphaValue)
    dataX = dataXArray.to_a
    expectation = expectationY.to_i
    alpha = alphaValue.to_f

  end

  #bais 為目前此SVM的Bais
  #allPoints是一個裝Patten型態的Array
  #kernel要傳入Kernel class 來做kernel的計算
  def error(bais,allPoints,kernel)

    errorValue = 0.0

    allPoints.to_a.each do |patten|
      errorValue  =  errorValue + patten.expectation * patten.alpha * kernel.algorithmWithData(patten.dataX.to_a,dataX)
    end

    errorValue = errorValue + bais.to_f - expectation

  end

  def updateAlpha(newAlpha)
    alpha = newAlpha.to_f
  end
  
end