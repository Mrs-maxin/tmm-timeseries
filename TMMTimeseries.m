function projectSummary = TMMTimeseries()
%TMMTIMESERIES Run the registered research cases.
projectRoot = fileparts(mfilename("fullpath"));
addpath(projectRoot);

caseSummary = TMMTimeseries_case2bus();
summaryFile = fullfile(projectRoot, "result", "project_summary.txt");
projectSummary = struct("status", caseSummary.status, "caseName", caseSummary.caseName, ...
    "caseSummaryFile", caseSummary.summaryFile, "runManifestFile", caseSummary.runManifestFile);
TMMTimeseries_utils.io.write_summary(summaryFile, projectSummary);
end
