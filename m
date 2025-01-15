Return-Path: <linux-acpi+bounces-10692-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54449A12B45
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 19:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685CC165920
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 18:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A91D63FB;
	Wed, 15 Jan 2025 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKWDql6S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561191D63F7;
	Wed, 15 Jan 2025 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967539; cv=none; b=uvXUtMI6W9YmfvjJjHDjPiXmqJx74+/bO3pTJM/orwT+BCY3x9f9NYTj5LPqwgc8Cq3FjPf3pS6xKFLhibodwlbswFbWs6oph3zdc2voaAEFHUhEhbKd2tRViR53l0n/7V41Lmxh64Asy+WFsnsYVgatWgOf5TVP9mkeWZNMRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967539; c=relaxed/simple;
	bh=2AqbYDiUYPrdWrGXTuoKwlV2cxuZ4BjL0w6RrB2EAeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ah+tZIAEndWxB4duAtTB+DE0gisyd4FjqRHu8Lf4jnB4t2MFbLTg2aDN3vOrajl4F3PZ3omO5qRRS9jzopqMQ4LeGvZVACiVXwCjWavMFrNrlHO27/G0+AnWPNzDy5QLOKZ8kQFs4EL+KXkDb8r/XCn2q4jWc5t0GRe8HHTurFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKWDql6S; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e53aa843a24so351036276.0;
        Wed, 15 Jan 2025 10:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736967536; x=1737572336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RrhOZ/O3sbGXaNyAEkYqUpFxZAwHULOL0F+P2AAtUUo=;
        b=SKWDql6S72e1fiVq3Fjk2rP319f00A7p4IYF8jZZz2dE6ZNG+236b+gQbRRGx1n2oH
         uvGktgeqiclxh2VHD+TGfHReYA6D9nh2O/zZVvioJhRAFhaySYG0TPDoyRt2c/UJjrsy
         IW8xZAlnMVWFCj0LeNlLJjTriOw1rEimjc9pukjmXPBTPejZc4xhws8dxm7VsI/71wSW
         vsQzmh+RmqtSAsxY0ADMXLfN9JP4f5AbwztaDj1N3ILexdWMRS6QUT4RiiucIsTHQgiO
         qLeuGw6qei82eR8Y1ITMTaMxYF5m/oKYZaxcCwafhog6DsPQaSZZ28vtwS7alL/40Jsh
         uGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736967536; x=1737572336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrhOZ/O3sbGXaNyAEkYqUpFxZAwHULOL0F+P2AAtUUo=;
        b=ZTu27vJ+zPjmX1tns+CIDa/c0KobxMC44NMcdTEmK0u6RHLrxpTH/rWb9OHN+TVYQC
         cRKraPqMrlcU3zQrMBzDrCUkzr1Xyn7BGPIJqwqJcdsaChow0mDKUgwVwoy7AJDGCMYw
         MI3xWguiYMhLloobqToD/P4kwLwXBmVx0oknnyFMFGWlzOcRuRKj0HbvqJBOb0aw4VVe
         59dr3SGiANAmi4NNAX7HaJMnbFzK04G5kiRaKWyPkt/oBcElzAob51XFW0WxeSDwO1B7
         gttaXgVQlXMgXb+9cHoIqf2ITE2Ky9ARfHgVGNvItL08tyQ/enbut1kYbRmh8RW5lW+r
         DGbg==
X-Forwarded-Encrypted: i=1; AJvYcCVrHlwF5dpW1voYYSqaKBsxMQYmcCywVMKDuq1xbvkWQubVPE7pk1hABeTlKSRoySEGFQOiUiRb9dBH@vger.kernel.org, AJvYcCWkuuW2lMeR+1J9pr+1a0EXpVE0I/W5Ctmk4AbBOT5O8fY/YyQtRH+wFaWgoejrqzRcfxq0HWpFyGnPX90p@vger.kernel.org
X-Gm-Message-State: AOJu0YzCt7pzHMuRN44b0vJBD1DaDtE6MTZlBOfC0HfYsUOaBaa6JGsx
	Ya6Id06j5R2XLpWmOFmESHy66tyh26W5t5F3+f7seN8Peo1TaE39
X-Gm-Gg: ASbGnctiE0K9ERFKf7bWMlR7Z5hOgSt359AjoZSPH+pbXlqwEQEhUxjdSYIpHZPsgAI
	G3KYWgjR6h/OwlHDxD03+DZSLPHziHAsY153zgETuP0FGWi3Bb3dPqrR0iS8RkYccUvLK/NteGJ
	hJ444MbgqBAOvTnTmTD4L02oBNzKrmKCyCTzeXMMSrAUu2L9L+S1xDRXOpZ8gJTqDBIadt3ygQ8
	UE2kidRckUt1Uja6t3k8cIg9oOGNKimxXjkaGCOpdW3NtdnA/K5e/M=
X-Google-Smtp-Source: AGHT+IEau5nX+XYYQObXzEaXHU5dmvaYYhB8RpV3l5qViU6nP/FsMKuxmnlIjfuNgx/UrND7/W9c0w==
X-Received: by 2002:a25:3543:0:b0:e53:7c95:2894 with SMTP id 3f1490d57ef6-e579d730ff3mr274601276.24.1736967535978;
        Wed, 15 Jan 2025 10:58:55 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e55a595de62sm2393449276.18.2025.01.15.10.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 10:58:55 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: gourry@gourry.net,
	hyeonggon.yoo@sk.com,
	ying.huang@linux.alibaba.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	honggyu.kim@sk.com,
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
Subject: [PATCH v3] Weighted interleave auto-tuning
Date: Wed, 15 Jan 2025 10:58:54 -0800
Message-ID: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>
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
will not aid in relieving the bandwidth pressure in the other two nodes).

This patch introduces an auto-configuration mode for the interleave
weights that aims to balance the two goals of setting node weights to be
proportional to their bandwidths and keeping the weight values low.
In order to perform the weight re-scaling, we use an internal
"weightiness" value (fixed to 32) that defines interleave aggression.

In this auto configuration mode, node weights are dynamically updated
every time there is a hotplug event that introduces new bandwidth.

Users can also enter manual mode by writing "manual" to the new "mode"
sysfs interface. When a user enters manual mode, the system stops
dynamically updating any of the node weights, even during hotplug events
that can shift the optimal weight distribution. The system also enters
manual mode any time a user sets a node's weight by hand, using the
nodeN interface introduced in [1]. On the other hand, auto mode is
only entered by explicitly writing "auto" to the mode interface.

There is one functional change that this patch makes to the existing
weighted_interleave ABI: previously, writing 0 directly to a nodeN
interface was said to reset the weight to the system default. Before
this patch, the default for all weights were 1, which meant that writing
0 and 1 were functionally equivalent.

This patch introduces "real" defaults, but we have decided to move away
from letting users use 0 as a "set to default" interface. Rather, users
who want to use system defaults should use "auto" mode. This patch seems
to be the appropriate place to make this change, since we would like to
remove this usage before users begin to rely on the feature in
userspace. Moreover, users will not be losing any functionality; they
can still write 1 into a node if they want a weight of 1. Thus, we
deprecate the "write zero to reset" feature in favor of returning an
error, the same way we would return an error when the user writes any
other invalid weight to the interface.

[1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Co-developed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
Changelog
v3:
- Weightiness (max_node_weight) is now fixed to 32.
- Instead, the sysfs interface now exposes a "mode" parameter, which
  can either be "auto" or "manual".
  - Thank you Hyeonggon and Honggyu for the feedback.
- Documentation updated to reflect new sysfs interface, explicitly
  specifies that 0 is invalid.
  - Thank you Gregory and Ying for the discussion on how best to
    handle the 0 case.
- Re-worked nodeN sysfs store to handle auto --> manual shifts
- mempolicy_set_node_perf internally handles the auto / manual
  caes differently now. bw is always updated, iw updates depend on
  what mode the user is in.
- Wordsmithing comments for clarity.
- Removed RFC tag.

v2:
- Name of the interface is changed: "max_node_weight" --> "weightiness"
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

 ...fs-kernel-mm-mempolicy-weighted-interleave |  30 ++-
 drivers/acpi/numa/hmat.c                      |   1 +
 drivers/base/node.c                           |   7 +
 include/linux/mempolicy.h                     |   4 +
 mm/mempolicy.c                                | 212 ++++++++++++++++--
 5 files changed, 227 insertions(+), 27 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
index 0b7972de04e9..d30dc29c53ff 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
@@ -20,6 +20,30 @@ Description:	Weight configuration interface for nodeN
 		Minimum weight: 1
 		Maximum weight: 255
 
-		Writing an empty string or `0` will reset the weight to the
-		system default. The system default may be set by the kernel
-		or drivers at boot or during hotplug events.
+		Writing invalid values (i.e. any values not in [1,255],
+		empty string, ...) will return -EINVAL.
+
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/mode
+Date:		January 2025
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Auto-weighting configuration interface
+
+		Configuration modes for weighted interleave. Can take one of
+		two options: "manual" and "auto". Default is "auto".
+
+		In auto mode, all node weights are re-calculated and overwritten
+		(visible via the nodeN interfaces) whenever new bandwidth data
+		is made available either during boot or hotplug events.
+
+		In manual mode, node weights can only be updated by the user.
+		If a node is hotplugged while the user is in manual mode,
+		the node will have a default weight of 1.
+
+		Modes can be changed by writing either "auto" or "manual" to the
+		interface. All other strings will be ignored, and -EINVAL will
+		be returned. If "auto" is written to the interface but the
+		recalculation / updates fail at any point (-ENOMEM or -ENODEV)
+		then the mode will remain in manual mode.
+
+		Writing a new weight to a node directly via the nodeN interface
+		will also automatically update the system to manual mode.
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 80a3481c0470..cc94cba112dd 100644
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
index 0ea653fa3433..16e7a5a8ebe7 100644
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
index ce9885e0178a..0fe96f3ab3ef 100644
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
@@ -178,6 +179,9 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
 
 extern bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone);
 
+extern int mempolicy_set_node_perf(unsigned int node,
+				   struct access_coordinate *coords);
+
 #else
 
 struct mempolicy {};
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 04f35659717a..8777bd6229bc 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -109,6 +109,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
 #include <linux/swapops.h>
+#include <linux/gcd.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
@@ -138,16 +139,18 @@ static struct mempolicy default_policy = {
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
+static uint64_t *node_bw_table;
+
 /*
- * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
- * system-default value should be used. A NULL iw_table also denotes that
- * system-default values should be used. Until the system-default table
- * is implemented, the system-default is always 1.
- *
+ * iw_table is the interleave weight table.
+ * If bandwiddth data is available and the user is in auto mode, the table
+ * is populated with default values in [1,255].
  * iw_table is RCU protected
  */
 static u8 __rcu *iw_table;
 static DEFINE_MUTEX(iw_table_lock);
+static const int weightiness = 32;
+static bool weighted_interleave_auto = true;
 
 static u8 get_il_weight(int node)
 {
@@ -156,14 +159,113 @@ static u8 get_il_weight(int node)
 
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
+ * Convert bandwidth values into weighted interleave weights.
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
+	 * Bandwidths above this limit cause rounding errors when reducing
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
+	/*
+	 * Update bandwidth info, even in manual mode. That way, when switching
+	 * to auto mode in the future, iw_table can be overwritten using
+	 * accurate bw data.
+	 */
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
+	if (weighted_interleave_auto) {
+		reduce_interleave_weights(new_bw, new_iw);
+	} else if (old_iw) {
+		/*
+		 * The first time mempolicy_set_node_perf is called, old_iw
+		 * (iw_table) is null. If that is the case, assign a zeroed
+		 * table to it. Otherwise, free the newly allocated iw_table.
+		 */
+		mutex_unlock(&iw_table_lock);
+		kfree(new_iw);
+		kfree(old_bw);
+		return 0;
+	}
+
+	rcu_assign_pointer(iw_table, new_iw);
+	mutex_unlock(&iw_table_lock);
+	synchronize_rcu();
+	kfree(old_iw);
+	kfree(old_bw);
+	return 0;
+}
+
 /**
  * numa_nearest_node - Find nearest node by state
  * @node: Node id to start the search
@@ -1998,10 +2100,7 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
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
@@ -2010,7 +2109,6 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 	while (target) {
 		/* detect system default usage */
 		weight = table ? table[nid] : 1;
-		weight = weight ? weight : 1;
 		if (target < weight)
 			break;
 		target -= weight;
@@ -2401,7 +2499,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	unsigned long nr_allocated = 0;
 	unsigned long rounds;
 	unsigned long node_pages, delta;
-	u8 *table, *weights, weight;
+	u8 *weights, weight;
 	unsigned int weight_total = 0;
 	unsigned long rem_pages = nr_pages;
 	nodemask_t nodes;
@@ -2450,16 +2548,8 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
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
 
@@ -3394,7 +3484,7 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
 	if (count == 0 || sysfs_streq(buf, ""))
 		weight = 0;
-	else if (kstrtou8(buf, 0, &weight))
+	else if (kstrtou8(buf, 0, &weight) || weight == 0)
 		return -EINVAL;
 
 	new = kzalloc(nr_node_ids, GFP_KERNEL);
@@ -3411,11 +3501,68 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 	mutex_unlock(&iw_table_lock);
 	synchronize_rcu();
 	kfree(old);
+	weighted_interleave_auto = false;
 	return count;
 }
 
 static struct iw_node_attr **node_attrs;
 
+static ssize_t weighted_interleave_mode_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	if (weighted_interleave_auto)
+		return sysfs_emit(buf, "auto\n");
+	else
+		return sysfs_emit(buf, "manual\n");
+}
+
+static ssize_t weighted_interleave_mode_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	uint64_t *bw;
+	u8 *old_iw, *new_iw;
+
+	if (count == 0)
+		return -EINVAL;
+
+	if (sysfs_streq(buf, "manual")) {
+		weighted_interleave_auto = false;
+		return count;
+	} else if (!sysfs_streq(buf, "auto")) {
+		return -EINVAL;
+	}
+
+	new_iw = kcalloc(nr_node_ids, sizeof(u8), GFP_KERNEL);
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
+	weighted_interleave_auto = true;
+	return count;
+}
+
+static struct kobj_attribute wi_attr =
+	__ATTR(mode, 0664, weighted_interleave_mode_show,
+			   weighted_interleave_mode_store);
+
 static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
 				  struct kobject *parent)
 {
@@ -3432,6 +3579,7 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
 
 	for (i = 0; i < nr_node_ids; i++)
 		sysfs_wi_node_release(node_attrs[i], wi_kobj);
+
 	kobject_put(wi_kobj);
 }
 
@@ -3473,6 +3621,15 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
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
@@ -3489,6 +3646,13 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 		return err;
 	}
 
+	err = sysfs_create_group(wi_kobj, &wi_attr_group);
+	if (err) {
+		pr_err("failed to add sysfs [mode]\n");
+		kobject_put(wi_kobj);
+		return err;
+	}
+
 	for_each_node_state(nid, N_POSSIBLE) {
 		err = add_weight_node(nid, wi_kobj);
 		if (err) {
-- 
2.43.5


