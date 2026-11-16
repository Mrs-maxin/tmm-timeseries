# 交流方程与两时段连续低电压概率

## 1. 源荷轨迹

同一 `trajectoryId` 的两个时段使用同一源荷轨迹。节点有功、无功净注入为

$$
P_t=P_{\mathrm{wind},t}+P_{\mathrm{PV},t}-P_{\mathrm{load},t},
\qquad
Q_t=Q_{\mathrm{wind},t}+Q_{\mathrm{PV},t}-Q_{\mathrm{load},t}.
$$

潮流方程使用由基准容量换算的标幺注入。真实数据应保留风、光、荷设备的无功测量或计算依据。

## 2. 两节点交流电压

设平衡节点复电压为 1 p.u.，线路串联阻抗为 $z=r+\mathrm j x$，PQ 节点复电压为 $V_t=e_t+\mathrm j f_t$。采用节点向线路注入为正的约定，节点复功率满足

$$
S_t=P_t+\mathrm j Q_t=V_t\overline{(V_t-1)/z}.
$$

乘以 $\overline z$ 后得 $\overline z S_t=|V_t|^2-V_t$。因此

$$
f_t=-\operatorname{Im}(\overline z S_t),\qquad
e_t=\frac{1+\sqrt{1+4[\operatorname{Re}(\overline zS_t)-f_t^2]}}{2}.
$$

判别式为非负时取加号对应的高电压解，并用原交流功率方程核对残差。电压实部和虚部按轨迹组成 $X=(e_1,f_1,e_2,f_2)^\mathsf T$。令 $x_t=(e_t,f_t)^\mathsf T$，则 $|V_t|^2=x_t^\mathsf T x_t$，其增广矩阵分别为 $\operatorname{diag}(I_2,0)$ 和 $\operatorname{diag}(0,I_2)$。

## 3. 给定联合电压模型后的概率

设 $X$ 服从有限 Student-t 混合模型，分量参数为 $\pi_k,\mu_k,\Sigma_k,\nu_k$。令 $D=\{x:\lVert x\rVert_2<V_{\min}\}$。两个时段的电压均低于限值的概率为

$$
p_{12}=\sum_k\pi_k\int_D f_{1,k}(u)\Pr(x_2\in D\mid x_1=u,k)\,\mathrm du.
$$

第 $k$ 个分量中，第二时段的条件位置为
$\mu_2+\Sigma_{21}\Sigma_{11}^{-1}(u-\mu_1)$。令
$\delta=(u-\mu_1)^\mathsf T\Sigma_{11}^{-1}(u-\mu_1)$，则条件尺度为
$\frac{\nu_k+\delta}{\nu_k+2}(\Sigma_{22}-\Sigma_{21}\Sigma_{11}^{-1}\Sigma_{12})$，
自由度为 $\nu_k+2$。固定第二时段的虚部后，实部的允许区间概率由一元条件 Student-t CDF 求得，余下坐标做数值积分。标准多元 Student-t 分量的共同随机尺度也影响联合概率。

时间独立对照取两个完整逐时边缘概率的乘积。条件概率 $\Pr(x_2\in D\mid x_1\in D)$ 在首时段事件概率为正时由 $p_{12}/\Pr(x_1\in D)$ 求得。给定电压模型后的表达与源荷经交流潮流诱导的真实概率分别核对。
