Return-Path: <linux-acpi+bounces-10916-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6595AA2A976
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 14:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3E43A94EB
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBF02451D9;
	Thu,  6 Feb 2025 13:14:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266F246322;
	Thu,  6 Feb 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847687; cv=none; b=PVU4Vc76umfYhJ898eETXsHPZ0Zj/upzYVKr3VBOPo2B7oik3HjmmIvQ4OdN4szVRzdDqp826+C2EvOgxZN9ZUGTbVB+HdJKRlANXm0L7AI6PK9TTI8LPKse3eWo3Sn+tLlSuxMzNhWjHDn77QqM2FDc2FdTTfU8ORMAai1cF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847687; c=relaxed/simple;
	bh=7wAWv7KNzLYuWONX8P2qOHel2uyh5MjOnW19x/RZSYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sU28fI8wKeaIaYLIAinWaao3tM49h+s+He/C1PqV712qcCqePsnHhGWBP1/bM1pgZIRwQH6mCKOa+LevRh7hjSI94JZ6udapSL6gw7hw3Mf3ETZuvc8e1jX4xwCM7rzAM7Nl252PRBkdfgcCuvw+pYXDwBWuUs8jSkAADiEMfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YpcsN23tfz1W56x;
	Thu,  6 Feb 2025 21:10:16 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id A7F9C14022E;
	Thu,  6 Feb 2025 21:14:35 +0800 (CST)
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
Subject: [PATCH v5 8/8] cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq
Date: Thu, 6 Feb 2025 21:14:28 +0800
Message-ID: <20250206131428.3261578-9-zhenglifeng1@huawei.com>
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

Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
driver.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
 drivers/cpufreq/cppc_cpufreq.c                | 109 ++++++++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 206079d3bd5b..eaaa553a1819 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -268,6 +268,60 @@ Description:	Discover CPUs in the same CPU frequency coordination domain
 		This file is only present if the acpi-cpufreq or the cppc-cpufreq
 		drivers are in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/auto_select
+Date:		February 2025
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
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/auto_act_window
+Date:		February 2025
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
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference_val
+Date:		February 2025
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
+		This file is only present if the cppc-cpufreq driver is in use.
+
 
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8f512448382f..16a41fb19c92 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -815,10 +815,119 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 
 	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
 }
+
+static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
+{
+	bool val;
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
+	return sysfs_emit(buf, "%d\n", val);
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
+static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
+{
+	u64 val;
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
+	return sysfs_emit(buf, "%llu\n", val);
+}
+
+static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
+				     const char *buf, size_t count)
+{
+	u64 usec;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &usec);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_auto_act_window(policy->cpu, usec);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
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
+static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
+						       const char *buf, size_t count)
+{
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
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
+cpufreq_freq_attr_rw(energy_performance_preference_val);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
+	&auto_select,
+	&auto_act_window,
+	&energy_performance_preference_val,
 	NULL,
 };
 
-- 
2.33.0


