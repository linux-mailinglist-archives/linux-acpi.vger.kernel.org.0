Return-Path: <linux-acpi+bounces-10939-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A72A2CDF3
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Feb 2025 21:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8C03ADA56
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Feb 2025 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AAB1A00F2;
	Fri,  7 Feb 2025 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3gStFaX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48A187342
	for <linux-acpi@vger.kernel.org>; Fri,  7 Feb 2025 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959220; cv=none; b=eyrWt/YCHwbLvbf0BZbUB+H6vLgCKmuIBIJF41WG9iaHPzQy7mJ7kzIBzJOzC48OXnUuRvxeCQ67Zf1T403Wf8Csr6xKAJ7LYfprZ4GsLMHfS4CTGgdQk88+Vzig2PACiE2L6oprDD0o/87yjwGdKi+J3UkxMqM2gIxy58eXmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959220; c=relaxed/simple;
	bh=hwXmYzqG510So7CEj3Y9AKpPBPRpw5a+ZoJmoly4wW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIVMayE6dV4sNnW48h4yZM9alT/qfiilCAlRnKNavJOlVw9YqoTaCZInY/xdJ20X7KiaHrOEguELpU4SHJxON6NIGNgoy4gDLqMZF6reRcUI/INMkIkAQ30Co+XfuLVmMQSbTdFsZLUwCB5++hewF+Gt3MP9VQkzobsQev9a+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3gStFaX; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f99efce804so16572747b3.0
        for <linux-acpi@vger.kernel.org>; Fri, 07 Feb 2025 12:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738959216; x=1739564016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7mYJFebpoi4yOQtzJHtftr4mu1KzlJKTN1yGdBctV7U=;
        b=W3gStFaXUtO07Aj/bB09Gvn2zyv1kfihMUyfEvjmTUBuAMqDkWVr5eEze+RwKPDnLC
         W1ROfzE0wAVHc0C7ttMZIFUZMc81WqxnydiV9YrTW8BkONgH2mbsJb5t4HknfWSwDa8x
         8z300WqmnHVNj6lQmwfWKcKrMROH4+3WOfxiPJ/ohdcU7EMI/tdA8dyBNWtoiTtLyJrx
         Lmd46m+8wmc3EB2DynzlJ/GIwoXGcsmGX8TdKCfa6EfY0hnBKYvf7fjm099mltSJsi0F
         6mLiF4b255U6Fl95lnA41Al+ujt66PrqxcLF9Ehm3U9QGnU7Tm1mhF/Yx2pQFqX/sto9
         gmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738959216; x=1739564016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mYJFebpoi4yOQtzJHtftr4mu1KzlJKTN1yGdBctV7U=;
        b=APMZvov+LUMYRQai5vSKHvMWrVA8zY69oOFt9TexTGuzAZ/g4x5O1mvlJUf91PHLPn
         aKBvFnMvNyjJgulOm69zXP+DoGzeHsFj2t1KlR4ZYE67vGOyfdICRnfWxadMSCQ2Ijwt
         2qhiLq4Z8O2z+uHVWiIxj3YWWv8YwJMPwdEJxtfbGzDMdcx78CKyvTkW44JvQPkz1v4H
         hTVVWZEmLI2bEb/pBmdiJDWWnPxoclqxexrKasT0XgXnkusLehbvI35+e4q9AFSCwMuC
         mAqpDCqc+RhVgztg22DEgmd8bxd1ewWYQGbHv2B8KODc/oOvRf9Vrhq5BkjbPmmBO6fn
         x+jw==
X-Forwarded-Encrypted: i=1; AJvYcCVIDzMRKOvA9iT5rlvhQ/4ToGy9S6E6X496TfxAIe0WhyN68eNdYyObdnY81Dw8ZY0KPiK3K6r80N3f@vger.kernel.org
X-Gm-Message-State: AOJu0YzgqZMBA0evXGhGKc5BEZTlKR+6r6/oqDANd2LlHRD22/staUuR
	HngP7beVFlFLPwjMXngPgRma7rHNIOmM3UeG2sow1ZoDKawWpPbq
X-Gm-Gg: ASbGncutQoXq1pW9+qDEjg6Dyhvdj9H1ppmn7PYbEY/H0VPDP57uduF2qpgVp3LM/ec
	Q/UVGM7cLgbf3oEob5DPQqB/w/ItTGXLjePfx8WmnoEFXsu0FwzefrK3p6BBCZsxedWJPwRTPHO
	m4pxibL8k8ImLrJcJhHF5I3zhqniaHKLMm9vdmbsnIEmM/HZfereEy87mw2TlMgh6LAdDFbGvKa
	xx0CGcQu3mQYQubLQt9zop10T7lr6A69qJ8aoBbL1VVkpcCV4iPNqN+4kBjGhkN5x9f93Rxfnoe
	VXvvBMKeqegQsg==
X-Google-Smtp-Source: AGHT+IEj5+2JaKmommFYoDfCG03GC7hDejaD+3XiTT60PmEG6Fsl7wApn+z8yPD0v86UsaiMG5Lr6w==
X-Received: by 2002:a05:690c:4909:b0:6f9:a9ee:d92e with SMTP id 00721157ae682-6f9b2a06f98mr49954037b3.35.1738959216405;
        Fri, 07 Feb 2025 12:13:36 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99ffc0c0csm6627667b3.114.2025.02.07.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:13:35 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: gourry@gourry.net,
	hyeonggon.yoo@sk.com,
	ying.huang@linux.alibaba.com,
	honggyu.kim@sk.com
Cc: akpm@linux-foundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Fri,  7 Feb 2025 12:13:35 -0800
Message-ID: <20250207201335.2105488-1-joshua.hahnjy@gmail.com>
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
allowed for pages to be allocated across nodes according to user-set ratios.   

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

Users can also enter manual mode by writing "N" or "0" to the new "auto"
sysfs interface. When a user enters manual mode, the system stops
dynamically updating any of the node weights, even during hotplug events
that can shift the optimal weight distribution. The system also enters
manual mode any time a user sets a node's weight directly by using the
nodeN interface introduced in [1]. On the other hand, auto mode is
only entered by explicitly writing "Y" or "1" to the auto interface.

There is one functional change that this patch makes to the existing
weighted_interleave ABI: previously, writing 0 directly to a nodeN
interface was said to reset the weight to the system default. Before
this patch, the default for all weights were 1, which meant that writing
0 and 1 were functionally equivalent.

This patch introduces "real" defaults, but moves away from letting users
use 0 as a "set to default" interface. Rather, users who want to use
system defaults should use auto mode. This patch seems to be the
appropriate place to make this change, since we would like to remove
this usage before users begin to rely on the feature in userspace.
Moreover, users will not be losing any functionality; they can still
write 1 into a node if they want a weight of 1. Thus, we deprecate the
"write zero to reset" feature in favor of returning an error, the same
way we would return an error when the user writes any other invalid
weight to the interface.

[1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Co-developed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
Changelog
v5:
- I accidentally forgot to add the mm/mempolicy: subject tag since v1 of
  this patch. Added to the subject now!
- Wordsmithing, correcting typos, and re-naming variables for clarity.
- No functional changes.
v4:
- Renamed the mode interface to the "auto" interface, which now only
  emits either 'Y' or 'N'. Users can now interact with it by
  writing 'Y', '1', 'N', or '0' to it.
- Added additional documentation to the nodeN sysfs interface.
- Makes sure iw_table locks are properly held.
- Removed unlikely() call in reduce_interleave_weights.
- Wordsmithing

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
  case differently now. bw is always updated, iw updates depend on
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
 ...fs-kernel-mm-mempolicy-weighted-interleave |  38 +++-
 drivers/acpi/numa/hmat.c                      |   1 +
 drivers/base/node.c                           |   7 +
 include/linux/mempolicy.h                     |   4 +
 mm/mempolicy.c                                | 200 ++++++++++++++++--
 5 files changed, 233 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
index 0b7972de04e9..ef43228d135d 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
@@ -20,6 +20,38 @@ Description:	Weight configuration interface for nodeN
 		Minimum weight: 1
 		Maximum weight: 255
 
-		Writing an empty string or `0` will reset the weight to the
-		system default. The system default may be set by the kernel
-		or drivers at boot or during hotplug events.
+		Writing invalid values (i.e. any values not in [1,255],
+		empty string, ...) will return -EINVAL.
+
+		Changing the weight to a valid value will automatically
+		update the system to manual mode as well.
+
+What:		/sys/kernel/mm/mempolicy/weighted_interleave/auto
+Date:		February 2025
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Auto-weighting configuration interface
+
+		Configuration mode for weighted interleave. A 'Y' indicates
+		that the system is in auto mode, and a 'N' indicates that
+		the system is in manual mode. All other values are invalid.
+
+		In auto mode, all node weights are re-calculated and overwritten
+		(visible via the nodeN interfaces) whenever new bandwidth data
+		is made available during either boot or hotplug events.
+
+		In manual mode, node weights can only be updated by the user.
+		Note that nodes that are onlined with previously set / defaulted
+		weights will inherit those weights. If they were not previously
+		set or are onlined with missing bandwidth data, they will be
+		defaulted to a weight of 1.
+
+		Writing Y or 1 to the interface will enable auto mode, while
+		writing N or 0 will enable manual mode. All other strings will
+		be ignored, and -EINVAL will be returned.
+
+		If Y or 1 is written to the interface but the recalculation or
+		updates fail at any point (-ENOMEM or -ENODEV), then the system
+		will remain in manual mode.
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
index 04f35659717a..51edd3663667 100644
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
+ * If bandwidth data is available and the user is in auto mode, the table
+ * is populated with default values in [1,255].
  * iw_table is RCU protected
  */
 static u8 __rcu *iw_table;
 static DEFINE_MUTEX(iw_table_lock);
+static const int weightiness = 32;
+static bool weighted_interleave_auto = true;
 
 static u8 get_il_weight(int node)
 {
@@ -156,14 +159,114 @@ static u8 get_il_weight(int node)
 
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
+	uint64_t sum_bw = 0, sum_iw = 0;
+	uint64_t scaling_factor = 1, iw_gcd = 1;
+	unsigned int i = 0;
+
+	/* Recalculate the bandwidth distribution given the new info */
+	for (i = 0; i < nr_node_ids; i++)
+		sum_bw += bw[i];
+
+	/* If node is not set or has < 1% of total bw, use minimum value of 1 */
+	for (i = 0; i < nr_node_ids; i++) {
+		if (bw[i]) {
+			scaling_factor = 100 * bw[i];
+			new_iw[i] = max(scaling_factor / sum_bw, 1);
+		} else {
+			new_iw[i] = 1;
+		}
+		sum_iw += new_iw[i];
+	}
+
+	/*
+	 * Scale each node's share of the total bandwidth from percentages
+	 * to whole numbers in the range [1, weightiness]
+	 */
+	for (i = 0; i < nr_node_ids; i++) {
+		scaling_factor = weightiness * new_iw[i];
+		new_iw[i] = max(scaling_factor / sum_iw, 1);
+		if (i == 0)
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
+		memcpy(new_bw, old_bw, nr_node_ids * sizeof(uint64_t));
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
@@ -1998,10 +2101,7 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
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
@@ -2010,7 +2110,6 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 	while (target) {
 		/* detect system default usage */
 		weight = table ? table[nid] : 1;
-		weight = weight ? weight : 1;
 		if (target < weight)
 			break;
 		target -= weight;
@@ -3394,7 +3493,7 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
 	if (count == 0 || sysfs_streq(buf, ""))
 		weight = 0;
-	else if (kstrtou8(buf, 0, &weight))
+	else if (kstrtou8(buf, 0, &weight) || weight == 0)
 		return -EINVAL;
 
 	new = kzalloc(nr_node_ids, GFP_KERNEL);
@@ -3411,11 +3510,68 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
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
+		return sysfs_emit(buf, "Y\n");
+	else
+		return sysfs_emit(buf, "N\n");
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
+	if (sysfs_streq(buf, "N") || sysfs_streq(buf, "0")) {
+		weighted_interleave_auto = false;
+		return count;
+	} else if (!sysfs_streq(buf, "Y") && !sysfs_streq(buf, "1")) {
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
+	__ATTR(auto, 0664, weighted_interleave_mode_show,
+			   weighted_interleave_mode_store);
+
 static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
 				  struct kobject *parent)
 {
@@ -3473,6 +3629,15 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
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
@@ -3489,6 +3654,13 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
 		return err;
 	}
 
+	err = sysfs_create_group(wi_kobj, &wi_attr_group);
+	if (err) {
+		pr_err("failed to add sysfs [auto]\n");
+		kobject_put(wi_kobj);
+		return err;
+	}
+
 	for_each_node_state(nid, N_POSSIBLE) {
 		err = add_weight_node(nid, wi_kobj);
 		if (err) {
-- 
2.43.5


