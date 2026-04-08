function bcData = evaluate_drive(driveModel, boundarySegment, t, gridData, stateInterior)
%EVALUATE_DRIVE Evaluate the currently selected drive model on one boundary.
    bcData = driveModel.evaluate(driveModel, boundarySegment, t, gridData, stateInterior);
end
