# 证据索引

| 证据编号 | 结论 | 当前依据 | 状态 |
| --- | --- | --- | --- |
| E01 | C1 | [合成源荷输入](../data/case2bus/source_load.csv)、[算例入口](../TMMTimeseries_case2bus.m)及[交流方程](derivation.md)。执行后生成 `result/case2bus/run_manifest.json`、`period_voltages.csv` 和 `paired_voltages.csv`。 | 已核对公式、数据和调用关系；MATLAB 运行待验证。 |
| E02 | C2 | [两时段联合概率推导](derivation.md)第 3 节。 | 理论表达已登记，独立数值核对待实施。 |
| E03 | C3 | [同精度比较计划](story.md)。 | 尚未验证。 |

## 前期项目记录

相邻的 AQPPF_TMM 项目已有两节点及三节点的时序推导、四时段 IEEE 33 节点的合成场景结果。来源为原项目的 `01_IDEA/spatiotemporal_analytic_acppf_derivation_20261030.md`、`01_IDEA/case33_four_period_tail_protocol_20261104.md` 及 `01_IDEA/evidence_map.md`。四时段对比保持逐时源荷分布并匹配目标滞后相关系数，使用预先定义的下尾分位阈值。它支持所测合成工况的联合尾部差异，TMM 和 GMM 均未达到预设严格误差要求。上述记录作为本项目立项依据，结果复现按本项目后续算例登记。
