Return-Path: <linux-acpi+bounces-5520-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC6E8B7A35
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 16:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FB51F23C55
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 14:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D916177114;
	Tue, 30 Apr 2024 14:34:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01246770FD;
	Tue, 30 Apr 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487666; cv=none; b=rodQV6CkZJUAxtKgL0ku9qUaGlGuWsNnnku0W+i9NlzWKJwgqwh2npmP4DSCHbWyICZWzgIJZQu3TYT8vc/Bsc8/0fMdws2P05M3futbdQplJKAkdlEdXWmOBH6mInVhdjMf0E0hAAwvznUdAltiELz//CiwisyqWiIt8T7PBLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487666; c=relaxed/simple;
	bh=Xb2KtypOmSmAWsf5ZVqNnSzLwY055t5v8OqjuBbnZjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHTUK2Uo1nC2w9cV2uXWUmdnoGzOK+8EdnqRo2G+vFUNi7bbZvxIZ4I7eyBb+dyspn3rUWxzSj39AW+rdYMd9R46qlyMRHWT26Iadf6qSTSGlMr69zkwkVxvnXhbdxoMmQlFaS26R9xbRG8aKpDrQiU26HZeiIayY29P27TCDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTN1T736sz6J7Mw;
	Tue, 30 Apr 2024 22:31:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C86F1140A08;
	Tue, 30 Apr 2024 22:34:22 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 15:34:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Gavin Shan
	<gshan@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v9 19/19] cpumask: Add enabled cpumask for present CPUs that can be brought online
Date: Tue, 30 Apr 2024 15:24:34 +0100
Message-ID: <20240430142434.10471-20-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: James Morse <james.morse@arm.com>

The 'offline' file in sysfs shows all offline CPUs, including those
that aren't present. User-space is expected to remove not-present CPUs
from this list to learn which CPUs could be brought online.

CPUs can be present but not-enabled. These CPUs can't be brought online
until the firmware policy changes, which comes with an ACPI notification
that will register the CPUs.

With only the offline and present files, user-space is unable to
determine which CPUs it can try to bring online. Add a new CPU mask
that shows this based on all the registered CPUs.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v9: No change
---
 .../ABI/testing/sysfs-devices-system-cpu      |  6 +++++
 drivers/base/cpu.c                            | 10 ++++++++
 include/linux/cpumask.h                       | 25 +++++++++++++++++++
 kernel/cpu.c                                  |  3 +++
 4 files changed, 44 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 710d47be11e0..808efb5b860a 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -694,3 +694,9 @@ Description:
 		(RO) indicates whether or not the kernel directly supports
 		modifying the crash elfcorehdr for CPU hot un/plug and/or
 		on/offline changes.
+
+What:		/sys/devices/system/cpu/enabled
+Date:		Nov 2022
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) the list of CPUs that can be brought online.
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 7b83e9c87d7c..353ee39a5cbe 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -95,6 +95,7 @@ void unregister_cpu(struct cpu *cpu)
 {
 	int logical_cpu = cpu->dev.id;
 
+	set_cpu_enabled(logical_cpu, false);
 	unregister_cpu_under_node(logical_cpu, cpu_to_node(logical_cpu));
 
 	device_unregister(&cpu->dev);
@@ -273,6 +274,13 @@ static ssize_t print_cpus_offline(struct device *dev,
 }
 static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
 
+static ssize_t print_cpus_enabled(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_enabled_mask));
+}
+static DEVICE_ATTR(enabled, 0444, print_cpus_enabled, NULL);
+
 static ssize_t print_cpus_isolated(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -413,6 +421,7 @@ int register_cpu(struct cpu *cpu, int num)
 	register_cpu_under_node(num, cpu_to_node(num));
 	dev_pm_qos_expose_latency_limit(&cpu->dev,
 					PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
+	set_cpu_enabled(num, true);
 
 	return 0;
 }
@@ -494,6 +503,7 @@ static struct attribute *cpu_root_attrs[] = {
 	&cpu_attrs[2].attr.attr,
 	&dev_attr_kernel_max.attr,
 	&dev_attr_offline.attr,
+	&dev_attr_enabled.attr,
 	&dev_attr_isolated.attr,
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947db848..4b202b94c97a 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -93,6 +93,7 @@ static inline void set_nr_cpu_ids(unsigned int nr)
  *
  *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
  *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
+ *     cpu_enabled_mask  - has bit 'cpu' set iff cpu can be brought online
  *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
  *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
  *
@@ -125,11 +126,13 @@ static inline void set_nr_cpu_ids(unsigned int nr)
 
 extern struct cpumask __cpu_possible_mask;
 extern struct cpumask __cpu_online_mask;
+extern struct cpumask __cpu_enabled_mask;
 extern struct cpumask __cpu_present_mask;
 extern struct cpumask __cpu_active_mask;
 extern struct cpumask __cpu_dying_mask;
 #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
 #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
+#define cpu_enabled_mask   ((const struct cpumask *)&__cpu_enabled_mask)
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
 #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
@@ -1009,6 +1012,7 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
 #else
 #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
 #define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
+#define for_each_enabled_cpu(cpu)   for_each_cpu((cpu), cpu_enabled_mask)
 #define for_each_present_cpu(cpu)  for_each_cpu((cpu), cpu_present_mask)
 #endif
 
@@ -1031,6 +1035,15 @@ set_cpu_possible(unsigned int cpu, bool possible)
 		cpumask_clear_cpu(cpu, &__cpu_possible_mask);
 }
 
+static inline void
+set_cpu_enabled(unsigned int cpu, bool can_be_onlined)
+{
+	if (can_be_onlined)
+		cpumask_set_cpu(cpu, &__cpu_enabled_mask);
+	else
+		cpumask_clear_cpu(cpu, &__cpu_enabled_mask);
+}
+
 static inline void
 set_cpu_present(unsigned int cpu, bool present)
 {
@@ -1112,6 +1125,7 @@ static __always_inline unsigned int num_online_cpus(void)
 	return raw_atomic_read(&__num_online_cpus);
 }
 #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
+#define num_enabled_cpus()	cpumask_weight(cpu_enabled_mask)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
 
@@ -1120,6 +1134,11 @@ static inline bool cpu_online(unsigned int cpu)
 	return cpumask_test_cpu(cpu, cpu_online_mask);
 }
 
+static inline bool cpu_enabled(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_enabled_mask);
+}
+
 static inline bool cpu_possible(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_possible_mask);
@@ -1144,6 +1163,7 @@ static inline bool cpu_dying(unsigned int cpu)
 
 #define num_online_cpus()	1U
 #define num_possible_cpus()	1U
+#define num_enabled_cpus()	1U
 #define num_present_cpus()	1U
 #define num_active_cpus()	1U
 
@@ -1157,6 +1177,11 @@ static inline bool cpu_possible(unsigned int cpu)
 	return cpu == 0;
 }
 
+static inline bool cpu_enabled(unsigned int cpu)
+{
+	return cpu == 0;
+}
+
 static inline bool cpu_present(unsigned int cpu)
 {
 	return cpu == 0;
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 8f6affd051f7..537099bf5d02 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3117,6 +3117,9 @@ EXPORT_SYMBOL(__cpu_possible_mask);
 struct cpumask __cpu_online_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_online_mask);
 
+struct cpumask __cpu_enabled_mask __read_mostly;
+EXPORT_SYMBOL(__cpu_enabled_mask);
+
 struct cpumask __cpu_present_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_present_mask);
 
-- 
2.39.2


