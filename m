Return-Path: <linux-acpi+bounces-10547-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA1A0B6BA
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 13:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16727A3EC0
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 12:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B142397B7;
	Mon, 13 Jan 2025 12:21:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66132237A38;
	Mon, 13 Jan 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770880; cv=none; b=uWabq+Wi9lezTw3FCkKg4PZLN8zMK2oUM5L8wfUJIlHVaS2IDJmL8mjekqyZSDCMO6tikTkylJGHhV5TI49tn3W0vvfBIRsSuH2ZAKyavj9tI3xIeZxuC4SoAnFht7qxtPctBo8Oxz2URmFNmVimEHgTi8Id68MPho9Cf82qfmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770880; c=relaxed/simple;
	bh=i/VXOKlHN24K3aT7JmFKe3KAjVKXXypwpIPRo0RnR1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6zj4DgcU+zUvGNYwv9PF1HASZ7FoTChLoCDfjvueZWeS8bQHNjvgX/XKZH5lzK+PoSJsySi2kRDDrlLw0GiWI+AgLJgrfQiDoD1aiJb2PWS+LdCaUxWPAHKR0d0KHaTzyKRNOTMHw74/zSL+nbvs3NCKrV3tzHfTMsunYtOkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YWrrB6LZBz2DjgD;
	Mon, 13 Jan 2025 20:18:02 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B573F1400CB;
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
Subject: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq
Date: Mon, 13 Jan 2025 20:21:04 +0800
Message-ID: <20250113122104.3870673-7-zhenglifeng1@huawei.com>
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

Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
driver.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
 drivers/cpufreq/cppc_cpufreq.c                | 109 ++++++++++++++++++
 2 files changed, 163 insertions(+)

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
index bd8f75accfa0..ea6c6a5bbd8c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -814,10 +814,119 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 
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
+static ssize_t store_energy_perf(struct cpufreq_policy *policy,
+				 const char *buf, size_t count)
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


