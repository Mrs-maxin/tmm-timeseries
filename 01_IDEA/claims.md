# 研究结论及状态

| claimId | evidenceId | 可核查陈述 | primaryInnovationAxis | technicalObjectType | noveltyMode | lifecycleStage | manuscriptUse | evidenceState | evidenceBoundary |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| C1 | E01 | 固定平衡节点的两节点交流方程可逐时求得高电压解；同一轨迹的两个电压通过轨迹编号配对，并按两个时段的电压下限判定事件。 | technical-object | model-formulation | one-to-hundred | zero-to-one-first-run | conditional | implementation-supported | 两条合成风光荷轨迹，已核对公式与输入，MATLAB 运行待验证。 |
| C2 | E02 | 给定四维 Student-t 混合电压模型，连续低电压概率可写成第一时段圆盘内积分，积分项包含条件 Student-t 的第二时段电压平方 CDF。 | technical-object | algorithm-solution | one-to-hundred | zero-to-one-explore | conditional | theory-supported | 表达式适用于给定电压概率模型；时序参数和尾部拟合需按工况验证。 |
| C3 | E03 | 在统一运行条件和概率误差要求下，比较联合混合模型与序贯交流潮流蒙特卡洛的潮流次数和总耗时。 | technical-object | algorithm-solution | one-to-hundred | zero-to-one-explore | future-work | unverified | 训练数据、概率区间和目标误差待确定。 |
