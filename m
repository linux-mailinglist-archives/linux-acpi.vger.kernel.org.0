Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DE1D2B66
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2019 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbfJJNdc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Oct 2019 09:33:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387897AbfJJNdb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Oct 2019 09:33:31 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3C8C49C029AD8555264E;
        Thu, 10 Oct 2019 21:33:26 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 10 Oct 2019 21:33:19 +0800
From:   John Garry <john.garry@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <robert.moore@intel.com>,
        <erik.schmauss@intel.com>, <sudeep.holla@arm.com>,
        <rrichter@marvell.com>, <jeremy.linton@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linuxarm@huawei.com>, <gregkh@linuxfoundation.org>,
        <guohanjun@huawei.com>, <wanghuiqiang@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 2/3] ACPI/PPTT: Add support for ACPI 6.3 thread flag
Date:   Thu, 10 Oct 2019 21:29:51 +0800
Message-ID: <1570714192-236724-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1570714192-236724-1-git-send-email-john.garry@huawei.com>
References: <1570714192-236724-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jeremy Linton <jeremy.linton@arm.com>

Commit bbd1b70639f785a970d998f35155c713f975e3ac upstream.

ACPI 6.3 adds a flag to the CPU node to indicate whether
the given PE is a thread. Add a function to return that
information for a given linux logical CPU.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Robert Richter <rrichter@marvell.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Will Deacon <will@kernel.org>
[jpg: backport for 4.19, replace acpi_pptt_warn_missing()]
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/acpi/pptt.c  | 52 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |  5 +++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index da031b1df6f5..9dbf86a0c827 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -509,6 +509,44 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
 	return retval;
 }
 
+/**
+ * check_acpi_cpu_flag() - Determine if CPU node has a flag set
+ * @cpu: Kernel logical CPU number
+ * @rev: The minimum PPTT revision defining the flag
+ * @flag: The flag itself
+ *
+ * Check the node representing a CPU for a given flag.
+ *
+ * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found or
+ *	   the table revision isn't new enough.
+ *	   1, any passed flag set
+ *	   0, flag unset
+ */
+static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
+{
+	struct acpi_table_header *table;
+	acpi_status status;
+	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	struct acpi_pptt_processor *cpu_node = NULL;
+	int ret = -ENOENT;
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		pr_warn_once("No PPTT table found, cpu topology may be inaccurate\n");
+		return ret;
+	}
+
+	if (table->revision >= rev)
+		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
+
+	if (cpu_node)
+		ret = (cpu_node->flags & flag) != 0;
+
+	acpi_put_table(table);
+
+	return ret;
+}
+
 /**
  * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
  * @cpu: Kernel logical cpu number
@@ -573,6 +611,20 @@ int cache_setup_acpi(unsigned int cpu)
 	return status;
 }
 
+/**
+ * acpi_pptt_cpu_is_thread() - Determine if CPU is a thread
+ * @cpu: Kernel logical CPU number
+ *
+ * Return: 1, a thread
+ *         0, not a thread
+ *         -ENOENT ,if the PPTT doesn't exist, the CPU cannot be found or
+ *         the table revision isn't new enough.
+ */
+int acpi_pptt_cpu_is_thread(unsigned int cpu)
+{
+	return check_acpi_cpu_flag(cpu, 2, ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD);
+}
+
 /**
  * find_acpi_cpu_topology() - Determine a unique topology value for a given cpu
  * @cpu: Kernel logical cpu number
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b4d23b3a2ef2..59a416dfcaaa 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1291,10 +1291,15 @@ static inline int lpit_read_residency_count_address(u64 *address)
 #endif
 
 #ifdef CONFIG_ACPI_PPTT
+int acpi_pptt_cpu_is_thread(unsigned int cpu);
 int find_acpi_cpu_topology(unsigned int cpu, int level);
 int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
 #else
+static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
+{
+	return -EINVAL;
+}
 static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
 {
 	return -EINVAL;
-- 
2.17.1

