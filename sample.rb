require './svm'
require './pattern'
require './svm_manager'


# samples
kernel_type = KernelType.new
kernel_type.linear

# svm              = SVM.new(0.0001, 1000, 1, kernel_type)
# training_samples = [[0,0], [2,2], [2,0], [3,0]]
# samples_targets  = [-1, -1, 1, 1]
#
# svm.training_with_data_and_target(training_samples, samples_targets)

patterns = Array.new

patterns << Pattern.new([0,0], -2)
patterns << Pattern.new([2,2], -2)
patterns << Pattern.new([2,0], 2)
patterns << Pattern.new([3,0], 2)

svm_manager = SVMManager.new(0.0001, 1000, 1, kernel_type)
svm_manager.start_training_with_patterns(patterns)

result = svm_manager.classify_data_with_svm([5,0])
puts "Result = #{result}"