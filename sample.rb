require './svm'

# samples
svm              = SVM.new(0.0001, 1000, "Linear")
training_samples = [[0,0], [2,2], [2,0], [3,0]]
samples_targets  = [-1, -1, 1, 1]
svm.training(training_samples, samples_targets, "Linear")