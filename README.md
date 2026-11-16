# 计及时序相关性的交流概率潮流

TMMTimeseries 是基于 [project-template-lite](https://github.com/wuhanichina/project-template-lite) 的 MATLAB 研究项目。模板版本为 2026.11.04，上游提交为 `3c49c43cd6215d35b57abdd3ade985eb8c6c7c8f`。

## 研究问题

本项目从保留时序依赖的风光荷轨迹估计节点连续低电压概率，并与序贯交流潮流蒙特卡洛比较同精度下的计算成本。首个算例采用两节点系统，统计同一条轨迹上两个相邻的 15 分钟时段均低于电压下限的事件。

1. 运行两节点教学算例，核对净注入、交流潮流残差、轨迹配对和低电压事件标记。现有 MATLAB 代码已包含这些步骤，实际运行待验证。
2. 实现联合 Student-t 混合模型的拟合与连续低电压概率计算，分别检验概率积分误差及电压联合分布拟合误差。
3. 对照联合高斯混合模型、逐时独立近似和序贯交流潮流蒙特卡洛，核查联合概率误差、交流潮流求解次数及总耗时。

[研究任务与验收条件](https://github.com/Mrs-maxin/tmm-timeseries/blob/main/01_IDEA/story.md) · [交流方程与概率推导](https://github.com/Mrs-maxin/tmm-timeseries/blob/main/01_IDEA/derivation.md) · [结论及证据状态](https://github.com/Mrs-maxin/tmm-timeseries/blob/main/01_IDEA/evidence_map.md) · [文献目录](https://github.com/Mrs-maxin/tmm-timeseries/tree/main/03_REFERENCE)

## 项目材料与本地使用

[GitHub 主分支](https://github.com/Mrs-maxin/tmm-timeseries/tree/main)保存 MATLAB 源码、合成算例输入、研究记录、稿件源文件和文献目录。本地默认检出 `README.md`、`AGENTS.md`、`01_IDEA/story.md` 和 `.gitignore`。在项目根目录运行下列命令可以取回全部已跟踪文件。

```sh
git pull --ff-only
git sparse-checkout disable
```

结束本地计算或编辑后，提交并推送相关变更，再恢复精简检出。

```sh
git sparse-checkout set --no-cone '/README.md' '/AGENTS.md' '/01_IDEA/story.md' '/.gitignore'
```

在文献目录查看论文来源与版本。运行生成的缓存及临时结果保存在本地，正式计算结果在证据索引中登记。

## 两时段教学算例

在 MATLAB R2025a 或更新版本中打开本项目目录，按需调用 `TMMTimeseries_case2bus`。项目入口 `TMMTimeseries` 调用同一算例并更新项目汇总。算例读取两条合成风光荷轨迹，求逐时交流电压，输出配对的实部和虚部以及低电压事件标记。结果写入 `result/case2bus/`，含输入指纹与运行清单。

[算例输入与字段](https://github.com/Mrs-maxin/tmm-timeseries/tree/main/data) · [研究记录](https://github.com/Mrs-maxin/tmm-timeseries/blob/main/01_IDEA/research_trace.yaml)
