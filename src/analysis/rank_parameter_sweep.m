function ranking = rank_parameter_sweep(resultsTable, scoreColumn)
%RANK_PARAMETER_SWEEP Sort a results table by descending objective score.
    ranking = sortrows(resultsTable, scoreColumn, 'descend');
end
