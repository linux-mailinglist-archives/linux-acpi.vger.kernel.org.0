Return-Path: <linux-acpi+bounces-10198-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121809F83F2
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 20:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7A5189204A
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 19:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58B1AAA21;
	Thu, 19 Dec 2024 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dp633XcA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE01A0BE1;
	Thu, 19 Dec 2024 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635929; cv=none; b=V4IXDUTrrgqJSsbO8Ef02Ae6BXS2uR3+p10EGWdE5dtXsjC83+G3ScmO3YK7fQPR2Rrgva9GDBy6ZycUXVVKrgrs5Db2rdiRPUhRDiZAo4wc1NZKEyWGvgKsklPZZqfZI6Jhv4LwxiCap7kTFwPKkMsCVwpeBhcvvFLEXypF2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635929; c=relaxed/simple;
	bh=i2spN/x9aOsp7IPUoxXaB2byrLj1bqQkb569rgNg3SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHj7bLJR2SbEBBJ4lM9z2HEdhH1DTJ++TN9D3TGD4+nbUCjOy2Mj4TJiHtgGWb7ZjCxl9UCIUlXTnWenfGYw6xebbJ8hciokJFO7v+ikD75KazZLRGAn6Q8HZnThK0NFOLmppvUW9moMobCMoouCXgW7DNs1q+3sy5SyDLDh7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dp633XcA; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ef7c9e9592so12615377b3.1;
        Thu, 19 Dec 2024 11:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734635926; x=1735240726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=25+vtXKNYpEbk74TE2SwqRxiUv+OpbQXae8RKLLyaG4=;
        b=dp633XcAQjxkNtx206iykPE3SS0iU9/ye4uU/jhoKWRWmWR98DPKcUdG5qHCUskQUE
         ti8ml1AZgl0T6DtQDkE7uHerE9vFQX68hv+jNK0IbjeKXhFFxLLB/+1VQU0IzFhDr59M
         CLWqqESLvPM5OEmKaMrzwm7CGTvo8nXwXDkkTj60d7x+6U26OPPLT1lcdrYJc0OWTBaT
         aC6ymvmmqdiyK9htoAHlxn16N9hkYKIa+xVyhcDpV+CS+/HayRel5P6Y84Fhv50LIMDu
         a/0VCJu/H5JE8WFYnH+5oxcIGTwWU504Rrc4i483S/JNgxyhaaHdkxato+A7Miid0g4H
         F3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734635926; x=1735240726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25+vtXKNYpEbk74TE2SwqRxiUv+OpbQXae8RKLLyaG4=;
        b=qqH+BTw56xdnw0PD2fY0/jWWTq7hF+204ICFbyUFGs+2vVo+OOHPZGp6A1VLSWEr+Y
         dkSEif4/ug2NZ68R67phTHBaVi91dm52UQp+f3ElIK4epufpfWt/YRW07M+TVNHi+NgD
         ZnUN8/8FbAzTkEsFwbmcTUdmfEBSpMmi99SBX0R8fDaJv3iPkRQ2JDvLkAWkXyHr0nxi
         tcN5/TcRcHYqyfhXz8hfKKNTuNBYLx540RjPTG3TxQ2qBk57Uf3MwPrOPfOo3uryviDc
         SiKfLOjmVmUVBFTr8DVj/cw4jbLwrwJ1/HRlcSg9lWKTNn8+qpMJq5My8U5AELMuu0fr
         9f6w==
X-Forwarded-Encrypted: i=1; AJvYcCVEmw9cr7qfGug4zf7DE6iWoNCdsSihfxREyRQ8rVEiUNPrWgMsOtB193g92xl0R+PMJ5wjLoKU4TB2@vger.kernel.org, AJvYcCWWACQOQg70Q3RGoWdI9oe5T+L64TTW8qTelQ9RX5BIrAKmOGXmdoGTV5dFKA62eU4Fo0rppMywODU+wmbn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7P8yn/KxKb33gDwRm/lVignqVHwRFIupa+r1gpc2msDpWj/T
	SGmaaXHJ9tLUPYS+gnXNcFjsJ7HhobDzJ4zoZFwg0X4oqlcEShQd
X-Gm-Gg: ASbGnctS69x6VIEhXuQwcm2L5ju8izMgLtcvPiS6Hc0YKfXg7tRXzPGaEsr2o85f9wu
	hWJHOxq15dIYdxizyt72JdYSzaUgRxBLHX+Melpa9zQOWSBuE6pUelssrcFJxchm9wU2R1fi8qk
	r/pC1z8fWq9Z57+5JrhDk8QwKEFt5AHUt3msQlL1YyS9wSO949ffU5cZKml0IgA8zxniRY5YQ/s
	MBqdT/lmHnfHWZu3wwPgQqPfPoTKymNKgBMsiCavLY3iCd6zRaQF1E=
X-Google-Smtp-Source: AGHT+IEbjrePzPhqFj+OpbVDSqSPJ9hjZMOnnqwwrz9lMVpUlJ/mA71spAHqYgTF226F354Zzw8/Lg==
X-Received: by 2002:a05:690c:6b02:b0:6ef:6d37:181d with SMTP id 00721157ae682-6f3e1b311a5mr47454447b3.8.1734635926424;
        Thu, 19 Dec 2024 11:18:46 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7477596sm4188387b3.54.2024.12.19.11.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:18:45 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: gourry@gourry.net,
	hyeonggon.yoo@sk.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	honggyu.kim@sk.com,
	ying.huang@linux.alibaba.com,
	rakie.kim@sk.com,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [RFC PATCH v2] Weighted interleave auto-tuning
Date: Thu, 19 Dec 2024 11:18:45 -0800
Message-ID: <20241219191845.3506370-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On machines with multiple memory nodes, interleaving page allocations
across nodes allows for better utilization of each node's bandwidth.
Previous work by Gregory Price [1] introduced weighted interleave, which
allowed for pages to be allocated across NUMA nodes according to
user-set ratios.

Ideally, these weights should be proportional to their bandwidth, so
that under bandwidth pressure, each node uses its maximal efficient
bandwidth and prevents latency from increasing exponentially.

At the same time, we want these weights to be as small as possible.
Having ratios that involve large co-prime numbers like 7639:1345:7 leads
to awkward and inefficient allocations, since the node with weight 7
will remain mostly unused (and despite being proportional to bandwidth,
will not aid in relieving the pressure present in the other two nodes).

This patch introduces an auto-configuration for the interleave weights
that aims to balance the two goals of setting node weights to be
proportional to their bandwidths and keeping the weight values low.
This balance is controlled by a value "weightiness", which defines the
interleaving aggression. Higher values lead to less interleaving
(255:1), while lower values lead to more interleaving (1:1).

Large weightiness values generally lead to increased weight-bandwidth
proportionality, but can lead to underutilized nodes (think worst-case
scenario, which is 1:max_node_weight). Lower weightiness reduces the
effects of underutilized nodes, but may lead to improperly loaded
distributions.

This knob is exposed as a sysfs interface with a default value of 32.
Weights are re-calculated once at boottime and then every time the knob
is changed by the user, or when the ACPI table is updated.

[1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Co-Developed-by: Gregory Price <gourry@gourry.net>

---
Changelog

v2:
- Name of the interface is changed from v1: "max_node_weight" --> "weightiness"
- Default interleave weight table no longer exists. Rather, the
  interleave weight table is initialized with the defaults, if bandwidth
  information is available.
  - In addition, all sections that handle iw_table have been changed
    to reference iw_table if it exists, otherwise defaulting to 1.
- All instances of unsigned long are converted to uint64_t to guarantee
  support for both 32-bit and 64-bit machines
- sysfs initialization cleanup
- Documentation has been rewritten to explicitly outline expected
  behavior and expand on the interpretation of "weightiness".
- kzalloc replaced with kcalloc for readability
- Thank you Gregory and Hyeonggon for your review & feedback!

 ...fs-kernel-mm-mempolicy-weighted-interleave |  36 ++++
 drivers/acpi/numa/hmat.c                      |   1 +
 drivers/base/node.c                           |   7 +
 include/linux/mempolicy.h                     |   4 +
 mm/mempolicy.c                                | 183 +++++++++++++++---
 5 files changed, 209 insertions(+), 22 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
index 0b7972de04e9..edb2c1f4753f 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
@@ -23,3 +23,39 @@ Description:	Weight configuration interface for nodeN
 		Writing an empty string or `0` will reset the weight to the
 		system default. The system default may be set by the kernel
 		or drivers at boot or during hotplug events.
+
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/weightiness
+Date:		December 2024
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Weight limiting / scaling interface
+
+		"Weightiness": a measure of interleave aggression between
+		memory nodes. Higher values lead to less interleaving (255:1),
+		while lower values lead to more interleaving (1:1).
+
+		When this value is updated, all node weights are re-calculated
+		to reflect the new weightiness. These re-calculated values
+		overwrite all existing node weights, including those manually
+		set by writing to the nodeN files.
+
+		Node weight re-calculation is performed by scaling down
+		bandwidth values reported in the ACPI HMAT to the range
+		[1, weightiness]. Note that re-calculation uses only the
+		weightiness parameter and bandwidth values, and ignores all
+		current node weights.
+
+		Minimum weight: 1
+		Default value: 32
+		Maximum weight: 255
+
+		Writing an empty string will set the value to be the default
+		(32). Writing a value outside the valid range  will return
+		EINVAL and will not re-trigger a weight scaling.
+
+		If there is no bandwidth data in the ACPI HMAT, then this file
+		will return ENODEV on an attempted write and perform no updates.
+		Furthermore, if there is no bandwidth information available,
+		all nodes' weights will default to 1.
+
+		Setting max_node_weight to 1 is equivalent to unweighted
+		interleave.
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index a2f9e7a4b479..83f3858a773f 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -20,6 +20,7 @@
 #include <linux/list_sort.h>
 #include <linux/memregion.h>
 #include <linux/memory.h>
+#include <linux/mempolicy.h>
 #include <linux/mutex.h>
 #include <linux/node.h>
 #include <linux/sysfs.h>
diff --git a/drivers/base/node.c b/drivers/base/node.c
index eb72580288e6..d45216386c03 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/memory.h>
+#include <linux/mempolicy.h>
 #include <linux/vmstat.h>
 #include <linux/notifier.h>
 #include <linux/node.h>
@@ -214,6 +215,12 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 			break;
 		}
 	}
+
+	/* When setting CPU access coordinates, update mempolicy */
+	if (access == ACCESS_COORDINATE_CPU) {
+		if (mempolicy_set_node_perf(nid, coord))
+			pr_info("failed to set node%d mempolicy attrs\n", nid);
+	}
 }
 EXPORT_SYMBOL_GPL(node_set_perf_attrs);
 
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 931b118336f4..d564e9e893ea 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
+#include <linux/node.h>
 #include <linux/nodemask.h>
 #include <linux/pagemap.h>
 #include <uapi/linux/mempolicy.h>
@@ -177,6 +178,9 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 
 extern bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone);
 
+extern int mempolicy_set_node_perf(unsigned int node,
+				   struct access_coordinate *coords);
+
 #else
 
 struct mempolicy {};
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ee32a10e992c..cb355bdcdd12 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -109,6 +109,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
 #include <linux/swapops.h>
+#include <linux/gcd.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
@@ -145,17 +146,19 @@ enum {
 };
 static unsigned int mempolicy_behavior;
 
+static uint64_t *node_bw_table;
+
 /*
- * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
- * system-default value should be used. A NULL iw_table also denotes that
- * system-default values should be used. Until the system-default table
- * is implemented, the system-default is always 1.
+ * iw_table is the interleave weight table, with default values populated
+ * using ACPI-reported bandwidths (if exists) and scaled down to [1,255].
  *
  * iw_table is RCU protected
  */
 static u8 __rcu *iw_table;
 static DEFINE_MUTEX(iw_table_lock);
 
+static int weightiness = 32;
+
 static u8 get_il_weight(int node)
 {
 	u8 *table;
@@ -163,14 +166,97 @@ static u8 get_il_weight(int node)
 
 	rcu_read_lock();
 	table = rcu_dereference(iw_table);
-	/* if no iw_table, use system default */
 	weight = table ? table[node] : 1;
-	/* if value in iw_table is 0, use system default */
-	weight = weight ? weight : 1;
 	rcu_read_unlock();
 	return weight;
 }
 
+/*
+ * Convert ACPI-reported bandwidths into weighted interleave weights for
+ * informed page allocation.
+ * Call with iw_table_lock.
+ */
+static void reduce_interleave_weights(uint64_t *bw, u8 *new_iw)
+{
+	uint64_t ttl_bw = 0, ttl_iw = 0, scaling_factor = 1, iw_gcd = 1;
+	unsigned int i = 0;
+
+	/* Recalculate the bandwidth distribution given the new info */
+	for (i = 0; i < nr_node_ids; i++)
+		ttl_bw += bw[i];
+
+	/* If node is not set or has < 1% of total bw, use minimum value of 1 */
+	for (i = 0; i < nr_node_ids; i++) {
+		if (bw[i]) {
+			scaling_factor = 100 * bw[i];
+			new_iw[i] = max(scaling_factor / ttl_bw, 1);
+		} else {
+			new_iw[i] = 1;
+		}
+		ttl_iw += new_iw[i];
+	}
+
+	/*
+	 * Scale each node's share of the total bandwidth from percentages
+	 * to whole numbers in the range [1, weightiness]
+	 */
+	for (i = 0; i < nr_node_ids; i++) {
+		scaling_factor = weightiness * new_iw[i];
+		new_iw[i] = max(scaling_factor / ttl_iw, 1);
+		if (unlikely(i == 0))
+			iw_gcd = new_iw[0];
+		iw_gcd = gcd(iw_gcd, new_iw[i]);
+	}
+
+	/* 1:2 is strictly better than 16:32. Reduce by the weights' GCD. */
+	for (i = 0; i < nr_node_ids; i++)
+		new_iw[i] /= iw_gcd;
+}
+
+int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
+{
+	uint64_t *old_bw, *new_bw;
+	uint64_t bw_val;
+	u8 *old_iw, *new_iw;
+
+	/*
+	 * Bandwidths above this limit causes rounding errors when reducing
+	 * weights. This value is ~16 exabytes, which is unreasonable anyways.
+	 */
+	bw_val = min(coords->read_bandwidth, coords->write_bandwidth);
+	if (bw_val > (U64_MAX / 10))
+		return -EINVAL;
+
+	new_bw = kcalloc(nr_node_ids, sizeof(uint64_t), GFP_KERNEL);
+	if (!new_bw)
+		return -ENOMEM;
+
+	new_iw = kcalloc(nr_node_ids, sizeof(u8), GFP_KERNEL);
+	if (!new_iw) {
+		kfree(new_bw);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&iw_table_lock);
+	old_bw = node_bw_table;
+	old_iw = rcu_dereference_protected(iw_table,
+					   lockdep_is_held(&iw_table_lock));
+
+	if (old_bw)
+		memcpy(new_bw, old_bw, nr_node_ids*sizeof(uint64_t));
+	new_bw[node] = bw_val;
+	node_bw_table = new_bw;
+
+	reduce_interleave_weights(new_bw, new_iw);
+	rcu_assign_pointer(iw_table, new_iw);
+
+	mutex_unlock(&iw_table_lock);
+	synchronize_rcu();
+	kfree(old_bw);
+	kfree(old_iw);
+	return 0;
+}
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -2014,10 +2100,7 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 	table = rcu_dereference(iw_table);
 	/* calculate the total weight */
 	for_each_node_mask(nid, nodemask) {
-		/* detect system default usage */
-		weight = table ? table[nid] : 1;
-		weight = weight ? weight : 1;
-		weight_total += weight;
+		weight_total += table ? table[nid] : 1;
 	}
 
 	/* Calculate the node offset based on totals */
@@ -2026,7 +2109,6 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 	while (target) {
 		/* detect system default usage */
 		weight = table ? table[nid] : 1;
-		weight = weight ? weight : 1;
 		if (target < weight)
 			break;
 		target -= weight;
@@ -2409,7 +2491,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	unsigned long nr_allocated = 0;
 	unsigned long rounds;
 	unsigned long node_pages, delta;
-	u8 *table, *weights, weight;
+	u8 *weights, weight;
 	unsigned int weight_total = 0;
 	unsigned long rem_pages = nr_pages;
 	nodemask_t nodes;
@@ -2458,16 +2540,8 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	if (!weights)
 		return total_allocated;
 
-	rcu_read_lock();
-	table = rcu_dereference(iw_table);
-	if (table)
-		memcpy(weights, table, nr_node_ids);
-	rcu_read_unlock();
-
-	/* calculate total, detect system default usage */
 	for_each_node_mask(node, nodes) {
-		if (!weights[node])
-			weights[node] = 1;
+		weights[node] = get_il_weight(node);
 		weight_total += weights[node];
 	}
 
@@ -3397,6 +3471,54 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct iw_node_attr **node_attrs;
 
+static ssize_t weightiness_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", weightiness);
+}
+
+static ssize_t weightiness_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	uint64_t *bw;
+	u8 *old_iw, *new_iw;
+	u8 new_weightiness;
+
+	if (count == 0 || sysfs_streq(buf, ""))
+		new_weightiness = 32;
+	else if (kstrtou8(buf, 0, &new_weightiness) || new_weightiness == 0)
+		return -EINVAL;
+
+	new_iw = kzalloc(nr_node_ids, GFP_KERNEL);
+	if (!new_iw)
+		return -ENOMEM;
+
+	mutex_lock(&iw_table_lock);
+	bw = node_bw_table;
+
+	if (!bw) {
+		mutex_unlock(&iw_table_lock);
+		kfree(new_iw);
+		return -ENODEV;
+	}
+
+	weightiness = new_weightiness;
+	old_iw = rcu_dereference_protected(iw_table,
+					   lockdep_is_held(&iw_table_lock));
+
+	reduce_interleave_weights(bw, new_iw);
+	rcu_assign_pointer(iw_table, new_iw);
+	mutex_unlock(&iw_table_lock);
+
+	synchronize_rcu();
+	kfree(old_iw);
+
+	return count;
+}
+
+static struct kobj_attribute wi_attr =
+	__ATTR(weightiness, 0664, weightiness_show, weightiness_store);
+
 static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
 				  struct kobject *parent)
 {
@@ -3413,6 +3535,7 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
 
 	for (i = 0; i < nr_node_ids; i++)
 		sysfs_wi_node_release(node_attrs[i], wi_kobj);
+
 	kobject_put(wi_kobj);
 }
 
@@ -3454,6 +3577,15 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
 	return 0;
 }
 
+static struct attribute *wi_default_attrs[] = {
+	&wi_attr.attr,
+	NULL
+};
+
+static const struct attribute_group wi_attr_group = {
+	.attrs = wi_default_attrs,
+};
+
 static int add_weighted_interleave_group(struct kobject *root_kobj)
 {
 	struct kobject *wi_kobj;
@@ -3470,6 +3602,13 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 		return err;
 	}
 
+	err = sysfs_create_group(wi_kobj, &wi_attr_group);
+	if (err) {
+		pr_err("failed to add sysfs [weightiness]\n");
+		kobject_put(wi_kobj);
+		return err;
+	}
+
 	for_each_node_state(nid, N_POSSIBLE) {
 		err = add_weight_node(nid, wi_kobj);
 		if (err) {
-- 
2.43.5


