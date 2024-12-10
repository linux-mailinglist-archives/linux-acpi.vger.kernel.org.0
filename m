Return-Path: <linux-acpi+bounces-10064-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B409EBC24
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 22:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191F61887E4A
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 21:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B56230D23;
	Tue, 10 Dec 2024 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMG2zUjE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21323ED78;
	Tue, 10 Dec 2024 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867685; cv=none; b=qwh9fe/tsFllz34MEnNkhdztRFazam0izln47A380chnmCo8c3ruhdcx+cf8ZRPoauoc8fUeSqCfSQJzEZxImGPXjz+oGuxiRryYFspL8EY0MvYDMz1ZBrdBJiL3+VC6zRpzpctHZKqiB4U6448d17/5L0URT5lQQaGbIW+G1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867685; c=relaxed/simple;
	bh=FoodDbJF85HSR7vqFb1SURwVFiFLxlq92hefFSTYsN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h534O8aGMQZN0PDbywHLZ5mjZfWH78bD9UP65AV70BWANCbuJ3HkbbfKl/xN1tvEkrj7Q21kIntku7Yzn9jt816xWV+Qg6e1FkLAx54Z1n+vmJU/tCoU4K2pUlzDQKwl55xiPXepo5Y9EyyKnamb2D0MWDnxhorAU8lg2pkYafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMG2zUjE; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef7640e484so71444527b3.3;
        Tue, 10 Dec 2024 13:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733867682; x=1734472482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CLMeg3KtiYPYLHuefeREp3hhLN8tVuKnI5cE4Kch8vA=;
        b=AMG2zUjExNyHeDsNLFJigdlTlXt3VZ7YOvgPeGTOsYX5FvZFBVaeQES9AQ/M+GWAfY
         Lkc8NR3xXEv8AqglcDCgFaYeW/1JVmfbzCt8/qexp/QiAZuwiWATP1kDUkw7afItIc9A
         EP8zOKjplVohei5Oysfgh5PrB1V9RoEB4k4hHGtGXZ0FquPFPD22ahcb5kO+cO6bUgNF
         RDaqg4YWsysERVTkcpRs5j/rYv8gGzo9+K7uHbsx1S08ZXOInIsRcmRAsxPfEiAZ4+Mu
         T0RzklMnDVH1SMptaaW0TwLGMqQUV//VumxfynS9AlisRvqsgcy+pogJ6Ts5Fyxek+SS
         mHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733867682; x=1734472482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLMeg3KtiYPYLHuefeREp3hhLN8tVuKnI5cE4Kch8vA=;
        b=U5d3DKDQ3Xjqy5P+Me2cL53HYcGADZkTI6oNFsaWit28FrWCnwkwumH60rDMG0mV9K
         igHw0q2VIAJm++uRkwhb+Yp+PsRdmWQS5yyHkfPmgTHEnZemmsIV9zpSDAGWHfWTzLXo
         tx8+iE8dlR7xVFJVQJtdPc/VDPPdgmJfSZECAKiyCPe589x15eLrhBp+gWznFzBj2OdW
         LJ2zJ7Hsy9LYR7pM9tSbgLXZEVbITxGSOpl97K6NLnjrUoqBsty9qL/aa+zGYBBdA6I9
         KAOkmrHCEYzJpa7B6gadxxBZJLF+DhfWogTo4SpePyODNphTV7ZkGN9ILtIBSx3Vft5j
         xs1g==
X-Forwarded-Encrypted: i=1; AJvYcCUDSETVpN622UvDLvrm0FpNjCKlUBblDxfvOK/z8mp/1/dQbtbr2Nbu4OUnYJWF5iH/qX5ohDRyFAwj@vger.kernel.org, AJvYcCVRIDJCGYIoQ8FkMx8dQtZc8DGvJ85bYK/IAnZGelIl/CCJaVPb/9k8bXc7CgaYDeEXazoiLlVuGM/o8RCq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1B8Dy8VRreMzC8LuHO8zXeX5VpDESWrIhaczmkm4DCX8grFr
	udAI+katcmWjSi330b1i9D8r9JP/xCAuBo42VfK5cii0dsDxzvlD
X-Gm-Gg: ASbGncsUNOaMXqxo0C6BUnkwc//ifa5w2WyrQHyX0fkzSQ4xIAnQYJi+Sq802vGPcTU
	pUOvvPg7ncjONYCelPSWO+JkCtro2vpaX5bZTSm0n61pjxwSxMYxm9WVgxFI//j9ypGo+2424pr
	N1xxS/I4feFPU/1/CW7iVxA4B4QfaWFvaQ7v02cjaKt+YbxS1Ah+U+5CoUNFERI4FcegrzFhpR3
	nHyXMuEg4dcE0C1uiZWpPwminKbIKpJu4+o9iBLyGguDVMPcKIRAwxEYCQ9yrOsmNcA5AaH4W0Q
	AFk34hWKDA4t+iM=
X-Google-Smtp-Source: AGHT+IEBU9zQf0CAnNhG1S1981KjuQutbNTd3IcROBOXkDqd2I0onmLUpHUjTZWJdHae7O25LE02ng==
X-Received: by 2002:a05:690c:6e01:b0:6ee:7797:672 with SMTP id 00721157ae682-6f147fd1c9bmr8670717b3.7.1733867681690;
        Tue, 10 Dec 2024 13:54:41 -0800 (PST)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6efd3889bfbsm29374367b3.53.2024.12.10.13.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:54:40 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: gourry@gourry.net
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
Subject: [RFC PATCH] mm/mempolicy: Weighted interleave auto-tuning
Date: Tue, 10 Dec 2024 13:54:39 -0800
Message-ID: <20241210215439.94819-1-joshua.hahnjy@gmail.com>
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
This balance is controlled by a value max_node_weight, which defines the
maximum weight a single node can take.

Large max_node_weights generally lead to increased weight-bandwidth
proportionality, but can lead to underutilized nodes (think worst-case
scenario, which is 1:max_node_weight). Lower max_node_weights reduce the
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
 ...fs-kernel-mm-mempolicy-weighted-interleave |  24 +++
 drivers/acpi/numa/hmat.c                      |   1 +
 drivers/base/node.c                           |   7 +
 include/linux/mempolicy.h                     |   4 +
 mm/mempolicy.c                                | 195 ++++++++++++++++--
 5 files changed, 211 insertions(+), 20 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
index 0b7972de04e9..2ef9a87ce878 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
@@ -23,3 +23,27 @@ Description:	Weight configuration interface for nodeN
 		Writing an empty string or `0` will reset the weight to the
 		system default. The system default may be set by the kernel
 		or drivers at boot or during hotplug events.
+
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/max_node_weight
+Date:		December 2024
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Weight limiting / scaling interface
+
+		The maximum interleave weight for a memory node. When it is
+		updated, any previous changes to interleave weights (i.e. via
+		the nodeN sysfs interfaces) are ignored, and new weights are
+		calculated using ACPI-reported bandwidths and scaled.
+
+		It is possible for weights to be greater than max_node_weight if
+		the nodeN interfaces are directly modified to be greater.
+
+		Minimum weight: 1
+		Default value: 32
+		Maximum weight: 255
+
+		Writing an empty string will set the value to be the default
+		(32). Writing a value outside the valid range  will return
+		EINVAL and will not re-trigger a weight scaling.
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
index ee32a10e992c..f789280acdcb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -109,6 +109,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
 #include <linux/swapops.h>
+#include <linux/gcd.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
@@ -153,24 +154,116 @@ static unsigned int mempolicy_behavior;
  *
  * iw_table is RCU protected
  */
+static unsigned long *node_bw_table;
+static u8 __rcu *default_iw_table;
+static DEFINE_MUTEX(default_iwt_lock);
+
 static u8 __rcu *iw_table;
 static DEFINE_MUTEX(iw_table_lock);
 
+static int max_node_weight = 32;
+
 static u8 get_il_weight(int node)
 {
-	u8 *table;
+	u8 *table, *defaults;
 	u8 weight;
 
 	rcu_read_lock();
+	defaults = rcu_dereference(default_iw_table);
 	table = rcu_dereference(iw_table);
-	/* if no iw_table, use system default */
-	weight = table ? table[node] : 1;
-	/* if value in iw_table is 0, use system default */
-	weight = weight ? weight : 1;
+	/* if no iw_table, use system default - if no default, use 1 */
+	weight = table ? table[node] : 0;
+	weight = weight ? weight : (defaults ? defaults[node] : 1);
 	rcu_read_unlock();
 	return weight;
 }
 
+/*
+ * Convert ACPI-reported bandwidths into weighted interleave weights for
+ * informed page allocation.
+ * Call with default_iwt_lock held
+ */
+static void reduce_interleave_weights(unsigned long *bw, u8 *new_iw)
+{
+	uint64_t ttl_bw = 0, ttl_iw = 0, scaling_factor = 1;
+	unsigned int iw_gcd = 1, i = 0;
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
+	 * to whole numbers in the range [1, max_node_weight]
+	 */
+	for (i = 0; i < nr_node_ids; i++) {
+		scaling_factor = max_node_weight * new_iw[i];
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
+	unsigned long *old_bw, *new_bw;
+	unsigned long bw_val;
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
+	new_bw = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
+	if (!new_bw)
+		return -ENOMEM;
+
+	new_iw = kzalloc(nr_node_ids, GFP_KERNEL);
+	if (!new_iw) {
+		kfree(new_bw);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&default_iwt_lock);
+	old_bw = node_bw_table;
+	old_iw = rcu_dereference_protected(default_iw_table,
+					   lockdep_is_held(&default_iwt_lock));
+
+	if (old_bw)
+		memcpy(new_bw, old_bw, nr_node_ids*sizeof(unsigned long));
+	new_bw[node] = bw_val;
+	node_bw_table = new_bw;
+
+	reduce_interleave_weights(new_bw, new_iw);
+	rcu_assign_pointer(default_iw_table, new_iw);
+
+	mutex_unlock(&default_iwt_lock);
+	synchronize_rcu();
+	kfree(old_bw);
+	kfree(old_iw);
+	return 0;
+}
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -2001,7 +2094,7 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 {
 	nodemask_t nodemask;
 	unsigned int target, nr_nodes;
-	u8 *table;
+	u8 *table, *defaults;
 	unsigned int weight_total = 0;
 	u8 weight;
 	int nid;
@@ -2012,11 +2105,12 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 
 	rcu_read_lock();
 	table = rcu_dereference(iw_table);
+	defaults = rcu_dereference(iw_table);
 	/* calculate the total weight */
 	for_each_node_mask(nid, nodemask) {
 		/* detect system default usage */
-		weight = table ? table[nid] : 1;
-		weight = weight ? weight : 1;
+		weight = table ? table[nid] : 0;
+		weight = weight ? weight : (defaults ? defaults[nid] : 1);
 		weight_total += weight;
 	}
 
@@ -2025,8 +2119,8 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 	nid = first_node(nodemask);
 	while (target) {
 		/* detect system default usage */
-		weight = table ? table[nid] : 1;
-		weight = weight ? weight : 1;
+		weight = table ? table[nid] : 0;
+		weight = weight ? weight : (defaults ? defaults[nid] : 1);
 		if (target < weight)
 			break;
 		target -= weight;
@@ -2409,7 +2503,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	unsigned long nr_allocated = 0;
 	unsigned long rounds;
 	unsigned long node_pages, delta;
-	u8 *table, *weights, weight;
+	u8 *weights, weight;
 	unsigned int weight_total = 0;
 	unsigned long rem_pages = nr_pages;
 	nodemask_t nodes;
@@ -2458,16 +2552,8 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
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
 
@@ -3396,6 +3482,7 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 }
 
 static struct iw_node_attr **node_attrs;
+static struct kobj_attribute *max_nw_attr;
 
 static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
 				  struct kobject *parent)
@@ -3413,6 +3500,10 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
 
 	for (i = 0; i < nr_node_ids; i++)
 		sysfs_wi_node_release(node_attrs[i], wi_kobj);
+
+	sysfs_remove_file(wi_kobj, &max_nw_attr->attr);
+	kfree(max_nw_attr->attr.name);
+	kfree(max_nw_attr);
 	kobject_put(wi_kobj);
 }
 
@@ -3454,6 +3545,63 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
 	return 0;
 }
 
+static ssize_t max_nw_show(struct kobject *kobj, struct kobj_attribute *attr,
+			char *buf)
+{
+	return sysfs_emit(buf, "%d\n", max_node_weight);
+}
+
+static ssize_t max_nw_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	unsigned long *bw;
+	u8 *old_iw, *new_iw;
+	u8 max_weight;
+
+	if (count == 0 || sysfs_streq(buf, ""))
+		max_weight = 32;
+	else if (kstrtou8(buf, 0, &max_weight) || max_weight == 0)
+		return -EINVAL;
+
+	new_iw = kzalloc(nr_node_ids, GFP_KERNEL);
+	if (!new_iw)
+		return -ENOMEM;
+
+	mutex_lock(&default_iwt_lock);
+	bw = node_bw_table;
+
+	if (!bw) {
+		mutex_unlock(&default_iwt_lock);
+		kfree(new_iw);
+		return -ENODEV;
+	}
+
+	max_node_weight = max_weight;
+	old_iw = rcu_dereference_protected(default_iw_table,
+					   lockdep_is_held(&default_iwt_lock));
+
+	reduce_interleave_weights(bw, new_iw);
+	rcu_assign_pointer(default_iw_table, new_iw);
+	mutex_unlock(&default_iwt_lock);
+
+	synchronize_rcu();
+	kfree(old_iw);
+
+	return count;
+}
+
+static struct kobj_attribute wi_attr =
+	__ATTR(max_node_weight, 0664, max_nw_show, max_nw_store);
+
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
@@ -3470,6 +3618,13 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 		return err;
 	}
 
+	err = sysfs_create_group(wi_kobj, &wi_attr_group);
+	if (err) {
+		pr_err("failed to add sysfs [max_node_weight]\n");
+		kobject_put(wi_kobj);
+		return err;
+	}
+
 	for_each_node_state(nid, N_POSSIBLE) {
 		err = add_weight_node(nid, wi_kobj);
 		if (err) {
-- 
2.43.5


