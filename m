Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FFD65DC27
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jan 2023 19:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbjADScN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Jan 2023 13:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240077AbjADSb5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jan 2023 13:31:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD56D5F95;
        Wed,  4 Jan 2023 10:31:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E4691063;
        Wed,  4 Jan 2023 10:32:37 -0800 (PST)
Received: from pierre123.arm.com (unknown [10.57.44.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 560783F663;
        Wed,  4 Jan 2023 10:31:51 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: [PATCH v4 5/6] ACPI: PPTT: Update acpi_find_last_cache_level() to acpi_get_cache_info()
Date:   Wed,  4 Jan 2023 19:30:28 +0100
Message-Id: <20230104183033.755668-6-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104183033.755668-1-pierre.gondois@arm.com>
References: <20230104183033.755668-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_find_last_cache_level() allows to find the last level of cache
for a given CPU. The function is only called on arm64 ACPI based
platforms to check for cache information that would be missing in
the CLIDR_EL1 register.
To allow populating (struct cpu_cacheinfo).num_leaves by only parsing
a PPTT, update acpi_find_last_cache_level() to get the 'split_levels',
i.e. the number of cache levels being split in data/instruction
caches.

It is assumed that there will not be data/instruction caches above a
unified cache.
If a split level consist of one data cache and no instruction cache
(or opposite), then the missing cache will still be populated
by default with minimal cache information, and maximal cpumask
(all non-existing caches have the same fw_token).

Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Rafael J. Wysocki  <rafael.j.wysocki@intel.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/arm64/kernel/cacheinfo.c | 11 +++--
 drivers/acpi/pptt.c           | 76 +++++++++++++++++++++++------------
 include/linux/cacheinfo.h     |  9 +++--
 3 files changed, 63 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 97c42be71338..36c3b07cdf2d 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -46,7 +46,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 int init_cache_level(unsigned int cpu)
 {
 	unsigned int ctype, level, leaves;
-	int fw_level;
+	int fw_level, ret;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 
 	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
@@ -59,10 +59,13 @@ int init_cache_level(unsigned int cpu)
 		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
 	}
 
-	if (acpi_disabled)
+	if (acpi_disabled) {
 		fw_level = of_find_last_cache_level(cpu);
-	else
-		fw_level = acpi_find_last_cache_level(cpu);
+	} else {
+		ret = acpi_get_cache_info(cpu, &fw_level, NULL);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (fw_level < 0)
 		return fw_level;
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 97c1d33822d1..10975bb603fb 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -81,6 +81,7 @@ static inline bool acpi_pptt_match_type(int table_type, int type)
  * acpi_pptt_walk_cache() - Attempt to find the requested acpi_pptt_cache
  * @table_hdr: Pointer to the head of the PPTT table
  * @local_level: passed res reflects this cache level
+ * @split_levels: Number of split cache levels (data/instruction).
  * @res: cache resource in the PPTT we want to walk
  * @found: returns a pointer to the requested level if found
  * @level: the requested cache level
@@ -100,6 +101,7 @@ static inline bool acpi_pptt_match_type(int table_type, int type)
  */
 static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
 					 unsigned int local_level,
+					 unsigned int *split_levels,
 					 struct acpi_subtable_header *res,
 					 struct acpi_pptt_cache **found,
 					 unsigned int level, int type)
@@ -113,8 +115,17 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
 	while (cache) {
 		local_level++;
 
+		if (!(cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)) {
+			cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache);
+			continue;
+		}
+
+		if (split_levels &&
+		    (acpi_pptt_match_type(cache->attributes, ACPI_PPTT_CACHE_TYPE_DATA) ||
+		     acpi_pptt_match_type(cache->attributes, ACPI_PPTT_CACHE_TYPE_INSTR)))
+			*split_levels = local_level;
+
 		if (local_level == level &&
-		    cache->flags & ACPI_PPTT_CACHE_TYPE_VALID &&
 		    acpi_pptt_match_type(cache->attributes, type)) {
 			if (*found != NULL && cache != *found)
 				pr_warn("Found duplicate cache level/type unable to determine uniqueness\n");
@@ -135,8 +146,8 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
 static struct acpi_pptt_cache *
 acpi_find_cache_level(struct acpi_table_header *table_hdr,
 		      struct acpi_pptt_processor *cpu_node,
-		      unsigned int *starting_level, unsigned int level,
-		      int type)
+		      unsigned int *starting_level, unsigned int *split_levels,
+		      unsigned int level, int type)
 {
 	struct acpi_subtable_header *res;
 	unsigned int number_of_levels = *starting_level;
@@ -149,7 +160,8 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
 		resource++;
 
 		local_level = acpi_pptt_walk_cache(table_hdr, *starting_level,
-						   res, &ret, level, type);
+						   split_levels, res, &ret,
+						   level, type);
 		/*
 		 * we are looking for the max depth. Since its potentially
 		 * possible for a given node to have resources with differing
@@ -165,29 +177,29 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
 }
 
 /**
- * acpi_count_levels() - Given a PPTT table, and a CPU node, count the caches
+ * acpi_count_levels() - Given a PPTT table, and a CPU node, count the cache
+ * levels and split cache levels (data/instruction).
  * @table_hdr: Pointer to the head of the PPTT table
  * @cpu_node: processor node we wish to count caches for
+ * @levels: Number of levels if success.
+ * @split_levels:	Number of split cache levels (data/instruction) if
+ *			success. Can by NULL.
  *
  * Given a processor node containing a processing unit, walk into it and count
  * how many levels exist solely for it, and then walk up each level until we hit
  * the root node (ignore the package level because it may be possible to have
- * caches that exist across packages). Count the number of cache levels that
- * exist at each level on the way up.
- *
- * Return: Total number of levels found.
+ * caches that exist across packages). Count the number of cache levels and
+ * split cache levels (data/instruction) that exist at each level on the way
+ * up.
  */
-static int acpi_count_levels(struct acpi_table_header *table_hdr,
-			     struct acpi_pptt_processor *cpu_node)
+static void acpi_count_levels(struct acpi_table_header *table_hdr,
+			      struct acpi_pptt_processor *cpu_node,
+			      unsigned int *levels, unsigned int *split_levels)
 {
-	int total_levels = 0;
-
 	do {
-		acpi_find_cache_level(table_hdr, cpu_node, &total_levels, 0, 0);
+		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
 		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
 	} while (cpu_node);
-
-	return total_levels;
 }
 
 /**
@@ -321,7 +333,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
 
 	while (cpu_node && !found) {
 		found = acpi_find_cache_level(table_hdr, cpu_node,
-					      &total_levels, level, acpi_type);
+					      &total_levels, NULL, level, acpi_type);
 		*node = cpu_node;
 		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
 	}
@@ -589,36 +601,48 @@ static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
 }
 
 /**
- * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
+ * acpi_get_cache_info() - Determine the number of cache levels and
+ * split cache levels (data/instruction) and for a PE.
  * @cpu: Kernel logical CPU number
+ * @levels: Number of levels if success.
+ * @split_levels:	Number of levels being split (i.e. data/instruction)
+ *			if success. Can by NULL.
  *
  * Given a logical CPU number, returns the number of levels of cache represented
  * in the PPTT. Errors caused by lack of a PPTT table, or otherwise, return 0
  * indicating we didn't find any cache levels.
  *
- * Return: Cache levels visible to this core.
+ * Return: -ENOENT if no PPTT table or no PPTT processor struct found.
+ *	   0 on success.
  */
-int acpi_find_last_cache_level(unsigned int cpu)
+int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
+			unsigned int *split_levels)
 {
 	struct acpi_pptt_processor *cpu_node;
 	struct acpi_table_header *table;
-	int number_of_levels = 0;
 	u32 acpi_cpu_id;
 
+	*levels = 0;
+	if (split_levels)
+		*split_levels = 0;
+
 	table = acpi_get_pptt();
 	if (!table)
 		return -ENOENT;
 
-	pr_debug("Cache Setup find last level CPU=%d\n", cpu);
+	pr_debug("Cache Setup: find cache levels for CPU=%d\n", cpu);
 
 	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
-	if (cpu_node)
-		number_of_levels = acpi_count_levels(table, cpu_node);
+	if (!cpu_node)
+		return -ENOENT;
 
-	pr_debug("Cache Setup find last level level=%d\n", number_of_levels);
+	acpi_count_levels(table, cpu_node, levels, split_levels);
 
-	return number_of_levels;
+	pr_debug("Cache Setup: last_level=%d split_levels=%d\n",
+		 *levels, split_levels ? *split_levels : -1);
+
+	return 0;
 }
 
 /**
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index ff0328f3fbb0..00d8e7f9d1c6 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -88,19 +88,22 @@ bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y);
 int detect_cache_attributes(unsigned int cpu);
 #ifndef CONFIG_ACPI_PPTT
 /*
- * acpi_find_last_cache_level is only called on ACPI enabled
+ * acpi_get_cache_info() is only called on ACPI enabled
  * platforms using the PPTT for topology. This means that if
  * the platform supports other firmware configuration methods
  * we need to stub out the call when ACPI is disabled.
  * ACPI enabled platforms not using PPTT won't be making calls
  * to this function so we need not worry about them.
  */
-static inline int acpi_find_last_cache_level(unsigned int cpu)
+static inline
+int acpi_get_cache_info(unsigned int cpu,
+			unsigned int *levels, unsigned int *split_levels)
 {
 	return 0;
 }
 #else
-int acpi_find_last_cache_level(unsigned int cpu);
+int acpi_get_cache_info(unsigned int cpu,
+			unsigned int *levels, unsigned int *split_levels);
 #endif
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
-- 
2.25.1

