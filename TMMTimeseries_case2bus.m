function runSummary = TMMTimeseries_case2bus()
%TMMTIMESERIES_CASE2BUS Calculate paired AC voltages for claim C1.

projectRoot = fileparts(mfilename("fullpath"));
addpath(projectRoot);
config = struct();
config.name = "case2bus";
config.network = "Two buses with one PQ bus and a fixed slack voltage";
config.description = "Two-period source and load examples with paired AC voltages";
config.claim = "C1";
config.evidenceId = "E01";
config.entryFunction = "TMMTimeseries_case2bus";
config.lifecycleStage = "zero-to-one-first-run";
config.workflowStatus = "diagnostic";
config.projectRoot = projectRoot;
config.dataDir = fullfile(projectRoot, "data", config.name);
config.inputFile = fullfile(config.dataDir, "source_load.csv");
config.cacheDir = fullfile(projectRoot, "cache", config.name);
config.resultDir = fullfile(projectRoot, "result", config.name);
config.figureDir = fullfile(config.resultDir, "figures");
config.seed = 0;
config.solver = "Closed-form high-voltage two-bus AC solution";
config.baseMVA = 1.0;
config.lineResistancePu = 0.08;
config.lineReactancePu = 0.06;
config.voltageMinPu = 0.95;
config.powerResidualTolerancePu = 1e-10;

tracker = TMMTimeseries_utils.workflow.create_step_tracker(3, config.name);
runContext = struct();
stage = struct("index", 3, "name", "prepare and read paired inputs");
try
    tracker.update(1, stage.name);
    runContext.runState = TMMTimeseries_utils.workflow.prepare_case_run(config);
    runContext.caseData = TMMTimeseries_utils.io.load_case_inputs(config);
    sourceLoad = readtable(config.inputFile, TextType="string");
    runContext.caseData.status = "completed";

    stage = struct("index", 4, "name", "solve AC voltages and count paired low-voltage events");
    tracker.update(2, stage.name);
    [periods, trajectories] = TMMTimeseries_core.powerflow.evaluate_two_period_voltage(sourceLoad, config);
    runContext.proposedResults = struct("status", "not_applicable");
    runContext.baselineResults = struct("status", "not_applicable");
    runContext.metrics = struct("status", "completed");

    stage = struct("index", 7, "name", "write diagnostic tables and run manifest");
    tracker.update(3, stage.name);
    periodFile = fullfile(config.resultDir, "period_voltages.csv");
    trajectoryFile = fullfile(config.resultDir, "paired_voltages.csv");
    summaryFile = fullfile(config.resultDir, "summary.txt");
    manifestFile = fullfile(config.resultDir, "run_manifest.json");
    writetable(periods, periodFile);
    writetable(trajectories, trajectoryFile);
    TMMTimeseries_utils.io.write_summary(summaryFile, struct( ...
        "trajectoryCount", height(trajectories), ...
        "bothLowCount", nnz(trajectories.bothLow), ...
        "historicalFractionInExample", mean(trajectories.bothLow), ...
        "voltageMinPu", config.voltageMinPu, ...
        "maxPowerResidualPu", max(periods.powerResidualPu)));
    runContext.outputFiles = struct("status", "completed", "summaryFile", summaryFile, ...
        "manifestFile", manifestFile, "files", [periodFile; trajectoryFile; summaryFile]);
    runContext.figureOutputs = struct("status", "not_applicable");
    runSummary = TMMTimeseries_utils.workflow.finalize_case_run(config, runContext.runState, ...
        runContext.caseData, runContext.proposedResults, runContext.baselineResults, ...
        runContext.metrics, runContext.outputFiles, runContext.figureOutputs);
    tracker.complete();
catch runError
    tracker.fail(runError);
    TMMTimeseries_utils.workflow.finalize_failed_case_run(config, ...
        stage, runError, runContext);
    rethrow(runError);
end
end
