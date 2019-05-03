Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC513617
	for <lists+linux-acpi@lfdr.de>; Sat,  4 May 2019 01:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfECXY2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 May 2019 19:24:28 -0400
Received: from foss.arm.com ([217.140.101.70]:40194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfECXY2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 May 2019 19:24:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56EC015AD;
        Fri,  3 May 2019 16:24:27 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.29.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B85B03F557;
        Fri,  3 May 2019 16:24:26 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, linuxarm@huawei.com, john.garry@huawei.com,
        Jeremy Linton <jeremy.linton@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 1/5] ACPI/PPTT: Trivial, change the capitalization of CPU
Date:   Fri,  3 May 2019 18:24:03 -0500
Message-Id: <20190503232407.37195-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503232407.37195-1-jeremy.linton@arm.com>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CPU is an acronym and customarily capitalized. Much of the
commenting in the PPTT code has been using "cpu" rather
than "CPU". Correct that, and other human readable strings.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pptt.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 065c4fc245d1..83a026765faa 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -164,7 +164,7 @@ static struct acpi_pptt_cache *acpi_find_cache_level(struct acpi_table_header *t
 }
 
 /**
- * acpi_count_levels() - Given a PPTT table, and a cpu node, count the caches
+ * acpi_count_levels() - Given a PPTT table, and a CPU node, count the caches
  * @table_hdr: Pointer to the head of the PPTT table
  * @cpu_node: processor node we wish to count caches for
  *
@@ -235,7 +235,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 /**
  * acpi_find_processor_node() - Given a PPTT table find the requested processor
  * @table_hdr:  Pointer to the head of the PPTT table
- * @acpi_cpu_id: cpu we are searching for
+ * @acpi_cpu_id: CPU we are searching for
  *
  * Find the subtable entry describing the provided processor.
  * This is done by iterating the PPTT table looking for processor nodes
@@ -456,21 +456,21 @@ static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_ta
 
 static void acpi_pptt_warn_missing(void)
 {
-	pr_warn_once("No PPTT table found, cpu and cache topology may be inaccurate\n");
+	pr_warn_once("No PPTT table found, CPU and cache topology may be inaccurate\n");
 }
 
 /**
  * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
  * @table: Pointer to the head of the PPTT table
- * @cpu: Kernel logical cpu number
+ * @cpu: Kernel logical CPU number
  * @level: A level that terminates the search
  * @flag: A flag which terminates the search
  *
- * Get a unique value given a cpu, and a topology level, that can be
- * matched to determine which cpus share common topological features
+ * Get a unique value given a CPU, and a topology level, that can be
+ * matched to determine which CPUs share common topological features
  * at that level.
  *
- * Return: Unique value, or -ENOENT if unable to locate cpu
+ * Return: Unique value, or -ENOENT if unable to locate CPU
  */
 static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 				     unsigned int cpu, int level, int flag)
@@ -510,7 +510,7 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
 		return -ENOENT;
 	}
 	retval = topology_get_acpi_cpu_tag(table, cpu, level, flag);
-	pr_debug("Topology Setup ACPI cpu %d, level %d ret = %d\n",
+	pr_debug("Topology Setup ACPI CPU %d, level %d ret = %d\n",
 		 cpu, level, retval);
 	acpi_put_table(table);
 
@@ -519,9 +519,9 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
 
 /**
  * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
- * @cpu: Kernel logical cpu number
+ * @cpu: Kernel logical CPU number
  *
- * Given a logical cpu number, returns the number of levels of cache represented
+ * Given a logical CPU number, returns the number of levels of cache represented
  * in the PPTT. Errors caused by lack of a PPTT table, or otherwise, return 0
  * indicating we didn't find any cache levels.
  *
@@ -534,7 +534,7 @@ int acpi_find_last_cache_level(unsigned int cpu)
 	int number_of_levels = 0;
 	acpi_status status;
 
-	pr_debug("Cache Setup find last level cpu=%d\n", cpu);
+	pr_debug("Cache Setup find last level CPU=%d\n", cpu);
 
 	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
 	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
@@ -551,14 +551,14 @@ int acpi_find_last_cache_level(unsigned int cpu)
 
 /**
  * cache_setup_acpi() - Override CPU cache topology with data from the PPTT
- * @cpu: Kernel logical cpu number
+ * @cpu: Kernel logical CPU number
  *
  * Updates the global cache info provided by cpu_get_cacheinfo()
  * when there are valid properties in the acpi_pptt_cache nodes. A
  * successful parse may not result in any updates if none of the
  * cache levels have any valid flags set.  Futher, a unique value is
  * associated with each known CPU cache entry. This unique value
- * can be used to determine whether caches are shared between cpus.
+ * can be used to determine whether caches are shared between CPUs.
  *
  * Return: -ENOENT on failure to find table, or 0 on success
  */
@@ -567,7 +567,7 @@ int cache_setup_acpi(unsigned int cpu)
 	struct acpi_table_header *table;
 	acpi_status status;
 
-	pr_debug("Cache Setup ACPI cpu %d\n", cpu);
+	pr_debug("Cache Setup ACPI CPU %d\n", cpu);
 
 	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
 	if (ACPI_FAILURE(status)) {
@@ -582,8 +582,8 @@ int cache_setup_acpi(unsigned int cpu)
 }
 
 /**
- * find_acpi_cpu_topology() - Determine a unique topology value for a given cpu
- * @cpu: Kernel logical cpu number
+ * find_acpi_cpu_topology() - Determine a unique topology value for a given CPU
+ * @cpu: Kernel logical CPU number
  * @level: The topological level for which we would like a unique ID
  *
  * Determine a topology unique ID for each thread/core/cluster/mc_grouping
@@ -596,7 +596,7 @@ int cache_setup_acpi(unsigned int cpu)
  * other levels beyond this use a generated value to uniquely identify
  * a topological feature.
  *
- * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
+ * Return: -ENOENT if the PPTT doesn't exist, or the CPU cannot be found.
  * Otherwise returns a value which represents a unique topological feature.
  */
 int find_acpi_cpu_topology(unsigned int cpu, int level)
@@ -606,12 +606,12 @@ int find_acpi_cpu_topology(unsigned int cpu, int level)
 
 /**
  * find_acpi_cpu_cache_topology() - Determine a unique cache topology value
- * @cpu: Kernel logical cpu number
+ * @cpu: Kernel logical CPU number
  * @level: The cache level for which we would like a unique ID
  *
  * Determine a unique ID for each unified cache in the system
  *
- * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
+ * Return: -ENOENT if the PPTT doesn't exist, or the CPU cannot be found.
  * Otherwise returns a value which represents a unique topological feature.
  */
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
@@ -643,17 +643,17 @@ int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 
 
 /**
- * find_acpi_cpu_topology_package() - Determine a unique cpu package value
- * @cpu: Kernel logical cpu number
+ * find_acpi_cpu_topology_package() - Determine a unique CPU package value
+ * @cpu: Kernel logical CPU number
  *
- * Determine a topology unique package ID for the given cpu.
+ * Determine a topology unique package ID for the given CPU.
  * This ID can then be used to group peers, which will have matching ids.
  *
  * The search terminates when either a level is found with the PHYSICAL_PACKAGE
  * flag set or we reach a root node.
  *
- * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
- * Otherwise returns a value which represents the package for this cpu.
+ * Return: -ENOENT if the PPTT doesn't exist, or the CPU cannot be found.
+ * Otherwise returns a value which represents the package for this CPU.
  */
 int find_acpi_cpu_topology_package(unsigned int cpu)
 {
-- 
2.21.0

