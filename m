Return-Path: <linux-acpi+bounces-10914-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CDEA2A968
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 14:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB040168DAA
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3023F290;
	Thu,  6 Feb 2025 13:14:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A60236A8E;
	Thu,  6 Feb 2025 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847679; cv=none; b=DXZZN/dRcL5AOQn4tVARhkiKF4vZ5P4MgyAY7dXzsT1W/tAwLOtJ2eVR3O/DqzPcctqRD+XYS5AlgQdkGmgTFzOaxFq25m1JAHKogFH763PbLl03o0zc4rXleNqaXz0zDH3U1TXZvEHJL3niG2heu39sFCTBnhyUe5IwtwsgAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847679; c=relaxed/simple;
	bh=5ctVPrKhJOZudjG64Xr3iyO4rI/3R7iXk5XHAk/qeHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyPKIYwT5xEJTlsuTTDWnmU9BIrtuutt4/U5993oBlnf+DCb2XjYfHcndmwag3RJMbTbcvAlgEc540yU6lPGiucbRybgIUqEQttAf5o8NomSBUfUxoObWO3l3r8KoZh8RIPBIITft7mVOWnpNHYo2g36n8kahVynmfiHT4Wj4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ypct80FZkz1V5xD;
	Thu,  6 Feb 2025 21:10:56 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id F26BB1402CF;
	Thu,  6 Feb 2025 21:14:34 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Feb 2025 21:14:34 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <yumpusamongus@gmail.com>,
	<srinivas.pandruvada@linux.intel.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<hepeng68@huawei.com>, <fanghao11@huawei.com>
Subject: [PATCH v5 7/8] ACPI: CPPC: Add three functions related to autonomous selection
Date: Thu, 6 Feb 2025 21:14:27 +0800
Message-ID: <20250206131428.3261578-8-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250206131428.3261578-1-zhenglifeng1@huawei.com>
References: <20250206131428.3261578-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

cppc_set_epp - write energy performance preference register value, based on
ACPI 6.5, s8.4.6.1.7

cppc_get_auto_act_window - read autonomous activity window register value,
based on ACPI 6.5, s8.4.6.1.6

cppc_set_auto_act_window - write autonomous activity window register value,
based on ACPI 6.5, s8.4.6.1.6

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 80 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h | 24 ++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index e4c663000e40..a075eaa83d6c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1607,6 +1607,86 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
 
+/**
+ * cppc_set_epp() - Write the EPP register.
+ * @cpu: CPU on which to write register.
+ * @epp_val: Value to write to the EPP register.
+ */
+int cppc_set_epp(int cpu, u64 epp_val)
+{
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
+ *
+ * According to ACPI 6.5, s8.4.6.1.6, the value read from the autonomous
+ * activity window register consists of two parts: a 7 bits value indicate
+ * significand and a 3 bits value indicate exponent.
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
+ *
+ * According to ACPI 6.5, s8.4.6.1.6, the value to write to the autonomous
+ * activity window register consists of two parts: a 7 bits value indicate
+ * significand and a 3 bits value indicate exponent.
+ */
+int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
+{
+	/* The max value to stroe is 1270000000 */
+	u64 max_val = CPPC_AUTO_ACT_WINDOW_MAX_SIG * int_pow(10, CPPC_AUTO_ACT_WINDOW_MAX_EXP);
+	int exp = 0;
+	u64 val;
+
+	if (auto_act_window > max_val)
+		return -EINVAL;
+
+	/*
+	 * The max significand is 127, when auto_act_window is larger than
+	 * 129, discard the precision of the last digit and increase the
+	 * exponent by 1.
+	 */
+	while (auto_act_window > CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH) {
+		auto_act_window /= 10;
+		exp += 1;
+	}
+
+	/* For 128 and 129, cut it to 127. */
+	if (auto_act_window > CPPC_AUTO_ACT_WINDOW_MAX_SIG)
+		auto_act_window = CPPC_AUTO_ACT_WINDOW_MAX_SIG;
+
+	val = (exp << CPPC_AUTO_ACT_WINDOW_SIG_BIT_SIZE) + auto_act_window;
+
+	return cppc_set_reg_val(cpu, AUTO_ACT_WINDOW, val);
+}
+EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
+
 /**
  * cppc_get_auto_sel() - Read autonomous selection register.
  * @cpu: CPU from which to read register.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 31767c65be20..325e9543e08f 100644
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
@@ -159,6 +168,9 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
+extern int cppc_set_epp(int cpu, u64 epp_val);
+extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
+extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
 extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
@@ -229,6 +241,18 @@ static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_set_epp(int cpu, u64 epp_val)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cppc_get_auto_sel(int cpu, bool *enable)
 {
 	return -EOPNOTSUPP;
-- 
2.33.0


