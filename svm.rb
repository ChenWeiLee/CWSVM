class SVM

  iteration = 1000
  weight = Array.new
  bais = 0.0
  c = 1
  tolerance = 0.0001
  alphas = []

  def initialize(toleranceValue,iterationValue,cValue)
    if toleranceValue.is_a? Float
      toleration = toleranceValue
    end

    if iteration.is_a? Integer
      iteration = iterationValue
    end

    if cValue.is_a? Float
      c = cValue
    end

  end

  def training(dataArrayX,dataArrayY)
    #當輸入的參數不是Array的時候就直接return
    if !(dataArrayX.is_a? Array) || !(dataArrayY.is_a? Array) || dataArrayX.size == 0
        return
    end

    #將預設的W設定成0
    weight = Array.new(dataArrayX[0].size)
    #將Alphas也都預設成0
    alphas = Array.new(dataArrayX.size)



  end

end

svm = SVM.new(1000,0.0001,1)

svm.training([[0,0],[2,2],[2,0],[3,0]],[-1,-1,1,1])