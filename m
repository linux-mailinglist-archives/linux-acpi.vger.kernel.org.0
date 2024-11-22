Return-Path: <linux-acpi+bounces-9732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA29D595A
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 07:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2591F234F0
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 06:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA0E176AD8;
	Fri, 22 Nov 2024 06:21:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C730170A01;
	Fri, 22 Nov 2024 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256466; cv=none; b=LrjgipkLB+262fjLgZKAz3AiDCNLEP5lJZwQ4ZkClVUwDn8sqg8i6hSQQ/DMud/V5O0hlDmh1DvF/qu46/fxsP/BGajtPavdH1u70uzs8xaFmaUKQ6EhTPnNgjTkFYdDCIgbdDN72mpGLUxbTUys51gvy8QvAghDr8hRqyeNtcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256466; c=relaxed/simple;
	bh=KegWEtr6BZ3xiNwobCQnLHFuCTh+SSPdH77v6AumHfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSX12Wgam+iqCv/GSA4HAfh5NztUvek63cBqpB/eQdbPQuBg8k+hoJZm1UfBG7pT3EOtRV4XbbyydZIgoOHuPzmSIuEgPr9Lh6sA2ywzLt6eBYhGxGa22qxbF7bOxyspBA1isWs9OpnFA514U4xi725Ozeo6HPgeVPGsKO7ya+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XvlLV403Hz21lYC;
	Fri, 22 Nov 2024 14:19:30 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id A2997180019;
	Fri, 22 Nov 2024 14:20:54 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 14:20:53 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v2 3/3] cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq
Date: Fri, 22 Nov 2024 14:20:51 +0800
Message-ID: <20241122062051.3658577-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241122062051.3658577-1-zhenglifeng1@huawei.com>
References: <20241122062051.3658577-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
driver.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++
 drivers/cpufreq/cppc_cpufreq.c                | 138 ++++++++++++++++++
 2 files changed, 192 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 206079d3bd5b..3d87c3bb3fe2 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -268,6 +268,60 @@ Description:	Discover CPUs in the same CPU frequency coordination domain
 		This file is only present if the acpi-cpufreq or the cppc-cpufreq
 		drivers are in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/auto_select
+Date:		October 2024
+Contact:	linux-pm@vger.kernel.org
+Description:	Autonomous selection enable
+
+		Read/write interface to control autonomous selection enable
+			Read returns autonomous selection status:
+				0: autonomous selection is disabled
+				1: autonomous selection is enabled
+
+			Write 'y' or '1' or 'on' to enable autonomous selection.
+			Write 'n' or '0' or 'off' to disable autonomous selection.
+
+		This file only presents if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/auto_act_window
+Date:		October 2024
+Contact:	linux-pm@vger.kernel.org
+Description:	Autonomous activity window
+
+		This file indicates a moving utilization sensitivity window to
+		the platform's autonomous selection policy.
+
+		Read/write an integer represents autonomous activity window (in
+		microseconds) from/to this file. The max value to write is
+		1270000000 but the max significand is 127. This means that if 128
+		is written to this file, 127 will be stored. If the value is
+		greater than 130, only the first two digits will be saved as
+		significand.
+
+		Writing a zero value to this file enable the platform to
+		determine an appropriate Activity Window depending on the workload.
+
+		Writing to this file only has meaning when Autonomous Selection is
+		enabled.
+
+		This file only presents if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/energy_perf
+Date:		October 2024
+Contact:	linux-pm@vger.kernel.org
+Description:	Energy performance preference
+
+		Read/write an 8-bit integer from/to this file. This file
+		represents a range of values from 0 (performance preference) to
+		0xFF (energy efficiency preference) that influences the rate of
+		performance increase/decrease and the result of the hardware's
+		energy efficiency and performance optimization policies.
+
+		Writing to this file only has meaning when Autonomous Selection is
+		enabled.
+
+		This file only presents if the cppc-cpufreq driver is in use.
+
 
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 2b8708475ac7..351ecdd49ad4 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -792,10 +792,148 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 
 	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
 }
+
+static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
+{
+	u64 val;
+	int ret;
+
+	ret = cppc_get_auto_sel(policy->cpu, &val);
+
+	/* show "<unsupported>" when this register is not supported by cpc */
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "%s\n", "<unsupported>");
+
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", val);
+}
+
+static ssize_t store_auto_select(struct cpufreq_policy *policy,
+				 const char *buf, size_t count)
+{
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_auto_sel(policy->cpu, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+#define AUTO_ACT_WINDOW_SIG_BIT_SIZE	(7)
+#define AUTO_ACT_WINDOW_EXP_BIT_SIZE	(3)
+#define AUTO_ACT_WINDOW_MAX_SIG	((1 << AUTO_ACT_WINDOW_SIG_BIT_SIZE) - 1)
+#define AUTO_ACT_WINDOW_MAX_EXP	((1 << AUTO_ACT_WINDOW_EXP_BIT_SIZE) - 1)
+/* AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
+#define AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
+
+static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
+{
+	unsigned int exp;
+	u64 val, sig;
+	int ret;
+
+	ret = cppc_get_auto_act_window(policy->cpu, &val);
+
+	/* show "<unsupported>" when this register is not supported by cpc */
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "%s\n", "<unsupported>");
+
+	if (ret)
+		return ret;
+
+	sig = val & AUTO_ACT_WINDOW_MAX_SIG;
+	exp = (val >> AUTO_ACT_WINDOW_SIG_BIT_SIZE) & AUTO_ACT_WINDOW_MAX_EXP;
+
+	return sysfs_emit(buf, "%llu\n", sig * int_pow(10, exp));
+}
+
+static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
+				     const char *buf, size_t count)
+{
+	unsigned long usec;
+	int digits = 0;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &usec);
+	if (ret)
+		return ret;
+
+	if (usec > AUTO_ACT_WINDOW_MAX_SIG * int_pow(10, AUTO_ACT_WINDOW_MAX_EXP))
+		return -EINVAL;
+
+	while (usec > AUTO_ACT_WINDOW_SIG_CARRY_THRESH) {
+		usec /= 10;
+		digits += 1;
+	}
+
+	if (usec > AUTO_ACT_WINDOW_MAX_SIG)
+		usec = AUTO_ACT_WINDOW_MAX_SIG;
+
+	ret = cppc_set_auto_act_window(policy->cpu,
+				       (digits << AUTO_ACT_WINDOW_SIG_BIT_SIZE) + usec);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t show_energy_perf(struct cpufreq_policy *policy, char *buf)
+{
+	u64 val;
+	int ret;
+
+	ret = cppc_get_epp_perf(policy->cpu, &val);
+
+	/* show "<unsupported>" when this register is not supported by cpc */
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "%s\n", "<unsupported>");
+
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", val);
+}
+
+#define ENERGY_PERF_MAX	(0xFF)
+
+static ssize_t store_energy_perf(struct cpufreq_policy *policy,
+				 const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val > ENERGY_PERF_MAX)
+		return -EINVAL;
+
+	ret = cppc_set_epp(policy->cpu, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 cpufreq_freq_attr_ro(freqdomain_cpus);
+cpufreq_freq_attr_rw(auto_select);
+cpufreq_freq_attr_rw(auto_act_window);
+cpufreq_freq_attr_rw(energy_perf);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
+	&auto_select,
+	&auto_act_window,
+	&energy_perf,
 	NULL,
 };
 
-- 
2.33.0


