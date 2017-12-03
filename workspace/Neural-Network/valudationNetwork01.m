function [accuracyRate ,resultMatrix,offsetVector] = validationNetwork(result_matrix,test_vector)
    testNum = length(test_vector);
    offsetVector = size(1,testNum);
    resultVector = size(1,testNum);
    resultMatrix = size(testNum,2);
    correctNum = 0;
    for i = 1 : testNum
        [~,resultVector(i)] = max(result_matrix(:,i));
    end
    for i = 1 : testNum
        offsetVector(i) = abs(resultVector(i) - test_vector(i));
        if offsetVector(i) == 0
            correctNum = correctNum + 1;
        end
    end
    accuracyRate = correctNum / testNum;
    resultMatrix = [resultVector',test_vector'];
end