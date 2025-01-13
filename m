Return-Path: <linux-acpi+bounces-10544-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF36CA0B6B1
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 13:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DB77A4058
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 12:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3922F156;
	Mon, 13 Jan 2025 12:21:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4B21ADB4;
	Mon, 13 Jan 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770875; cv=none; b=DzfiHw6Y0K+m9icnVLqSBqqXyDDcDllXcwp5wFGZ50O0oXCBSpDz9D005luHOdgFTcRbXmRqiHNXQ7tYDbt5Pqtq7mlfjgSbsn3s/Cm4EmmEYof7rlkKFgRBFepvZzFOUqQPXAkVkTiUJrOQWg2AVJYuJ9kDS2dWcWmLlGa326c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770875; c=relaxed/simple;
	bh=BNTMjvOdUIjsQnC2Xu8LK4wvih1lbAJG7hsAEDQHFh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+xX9pROoRWDQFTmiPe65FbY9i185zxF+I3PLr74DHqMWAPcreukCNj+09nvhNmXBFIGpgA/gwFB3XOIiKofQtFftur9mxZ2QT3Nu5XymAaL9u+ebmu5zs7yMeiU9UwhoUk0z9Do0SwMOggKkoe8MD/p+70q5/UM6yFzywoUdy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YWrqP52jtz1W41Q;
	Mon, 13 Jan 2025 20:17:21 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A1201800FE;
	Mon, 13 Jan 2025 20:21:10 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jan 2025 20:21:09 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<hepeng68@huawei.com>, <fanghao11@huawei.com>
Subject: [PATCH v4 5/6] ACPI: CPPC: Add autonomous selection ABIs
Date: Mon, 13 Jan 2025 20:21:03 +0800
Message-ID: <20250113122104.3870673-6-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100008.china.huawei.com (7.202.181.93)

cppc_set_epp - write energy performance preference register value

cppc_get_auto_act_window - read autonomous activity window register value

cppc_set_auto_act_window - write autonomous activity window register value

cppc_get_auto_sel - read autonomous selection enable register value,
modified from cppc_get_auto_sel_caps()

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c     | 82 ++++++++++++++++++++++++++++++++----
 drivers/cpufreq/amd-pstate.c |  3 +-
 include/acpi/cppc_acpi.h     | 30 +++++++++++--
 3 files changed, 103 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 03134613311d..7bfe30f7b40f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1568,23 +1568,89 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
 
 /**
- * cppc_get_auto_sel_caps - Read autonomous selection register.
- * @cpunum : CPU from which to read register.
- * @perf_caps : struct where autonomous selection register value is updated.
+ * cppc_set_epp() - Write the EPP register.
+ * @cpu: CPU on which to write register.
+ * @epp_val: Value to write to the EPP register.
  */
-int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
+int cppc_set_epp(int cpu, u64 epp_val)
 {
-	u64 auto_sel;
+	if (epp_val > CPPC_ENERGY_PERF_MAX)
+		return -EINVAL;
+
+	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
+}
+EXPORT_SYMBOL_GPL(cppc_set_epp);
+
+/**
+ * cppc_get_auto_act_window() - Read autonomous activity window register.
+ * @cpu: CPU from which to read register.
+ * @auto_act_window: Return address.
+ */
+int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
+{
+	unsigned int exp;
+	u64 val, sig;
+	int ret;
+
+	ret = cppc_get_reg_val(cpu, AUTO_ACT_WINDOW, &val);
+	if (ret)
+		return ret;
+
+	sig = val & CPPC_AUTO_ACT_WINDOW_MAX_SIG;
+	exp = (val >> CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) & CPPC_AUTO_ACT_WINDOW_MAX_EXP;
+	*auto_act_window = sig * int_pow(10, exp);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_get_auto_act_window);
+
+/**
+ * cppc_set_auto_act_window() - Write autonomous activity window register.
+ * @cpu: CPU on which to write register.
+ * @auto_act_window: usec value to write to the autonomous activity window register.
+ */
+int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
+{
+	u64 max_val = CPPC_AUTO_ACT_WINDOW_MAX_SIG * int_pow(10, CPPC_AUTO_ACT_WINDOW_MAX_EXP);
+	int digits = 0;
+	u64 val;
+
+	if (auto_act_window > max_val)
+		return -EINVAL;
+
+	while (auto_act_window > CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH) {
+		auto_act_window /= 10;
+		digits += 1;
+	}
+
+	if (auto_act_window > CPPC_AUTO_ACT_WINDOW_MAX_SIG)
+		auto_act_window = CPPC_AUTO_ACT_WINDOW_MAX_SIG;
+
+	val = (digits << CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) + auto_act_window;
+
+	return cppc_set_reg_val(cpu, AUTO_ACT_WINDOW, val);
+}
+EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
+
+/**
+ * cppc_get_auto_sel() - Read autonomous selection register.
+ * @cpu: CPU from which to read register.
+ * @enable: Return address.
+ */
+int cppc_get_auto_sel(int cpu, bool *enable)
+{
+	u64 val;
 	int ret;
 
-	ret = cppc_get_reg_val(cpunum, AUTO_SEL_ENABLE, &auto_sel);
+	ret = cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, &val);
 	if (ret)
 		return ret;
 
-	perf_caps->auto_sel = (bool)auto_sel;
+	*enable = (bool)val;
+
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
+EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
 
 /**
  * cppc_set_auto_sel - Write autonomous selection register.
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 66e5dfc711c0..8bc11d0618f8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -399,6 +399,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_caps cppc_perf;
 	u64 numerator;
+	bool auto_sel;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
@@ -420,7 +421,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
 
-	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);
+	ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);
 	if (ret) {
 		pr_warn("failed to get auto_sel, ret: %d\n", ret);
 		return 0;
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 62d368bcd9ec..325e9543e08f 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -32,6 +32,15 @@
 #define	CMD_READ 0
 #define	CMD_WRITE 1
 
+#define CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE	(7)
+#define CPPC_AUTO_ACT_WINDOW_EXP_BIT_SIZE	(3)
+#define CPPC_AUTO_ACT_WINDOW_MAX_SIG	((1 << CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) - 1)
+#define CPPC_AUTO_ACT_WINDOW_MAX_EXP	((1 << CPPC_AUTO_ACT_WINDOW_EXP_BIT_SIZE) - 1)
+/* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
+#define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
+
+#define CPPC_ENERGY_PERF_MAX	(0xFF)
+
 /* Each register has the folowing format. */
 struct cpc_reg {
 	u8 descriptor;
@@ -159,7 +168,10 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
-extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
+extern int cppc_set_epp(int cpu, u64 epp_val);
+extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
+extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
+extern int cppc_get_auto_sel(int cpu, bool *enable);
 extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
@@ -229,11 +241,23 @@ static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
 {
 	return -EOPNOTSUPP;
 }
-static inline int cppc_set_auto_sel(int cpu, bool enable)
+static inline int cppc_set_epp(int cpu, u64 epp_val)
 {
 	return -EOPNOTSUPP;
 }
-static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
+static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_auto_sel(int cpu, bool *enable)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_auto_sel(int cpu, bool enable)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.33.0


